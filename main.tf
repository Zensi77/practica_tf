# Configuramos el proveedor de AWS
provider "aws" {
  region = var.region
}

# Creamos el grupo de seguridad
resource "aws_security_group" "sg_backend" {
  name        = var.sg_backend
  description = var.sg_backend
}

resource "aws_security_group" "sg_frontend" {
  name        = var.sg_frontend
  description = var.sg_frontend
}

# Utilizamos un bucle para recorrer la lista de puertos definida como variable
resource "aws_security_group_rule" "frontend" {
  security_group_id = aws_security_group.sg_frontend.id
  type              = "ingress"

  count       = length(var.ports_frontend)
  from_port   = var.ports_frontend[count.index]
  to_port     = var.ports_frontend[count.index]
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "backend" {
  security_group_id = aws_security_group.sg_backend.id
  type              = "ingress"

  count       = length(var.ports_backend)
  from_port   = var.ports_backend[count.index]
  to_port     = var.ports_backend[count.index]
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos una instancia EC2
resource "aws_instance" "frontend" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.sg_frontend.name]

  user_data = file("./scripts/frontend.sh")

  tags = {
    Name = var.instance_frontend_name
  }
}

resource "aws_instance" "backend" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.sg_backend.name]

    user_data = file("./scripts/backend.sh")

  tags = {
    Name = var.instance_backend_name
  }
}

# Creamos una IP elástica y la asociamos a la instancia
resource "aws_eip" "ip_elastica_frontend" {
  instance = aws_instance.frontend.id
}

resource "aws_eip" "ip_elastica_backend" {
  instance = aws_instance.backend.id
}