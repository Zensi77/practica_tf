variable "region" {
  description = "Región de AWS donde se creará la instancia"
  type        = string
  default     = "us-east-1"
}

variable "ports_frontend" {
  description = "Puertos de entrada del grupo de seguridad frontend"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "ports_backend" {
  description = "Puertos de entrada del grupo de seguridad frontend"
  type        = list(number)
  default     = [22, 3306]
}

// Grupo de seguridad
variable "sg_frontend" {
  description = "Grupo de seguridad frontend"
  type        = string
  default     = "sg_frontend"
}

variable "sg_backend" {
  description = "Grupo de seguridad backend"
  type        = string
  default     = "sg_backend"
}

variable "ami_id" {
  description = "Identificador de la AMI"
  type        = string
  default     = "ami-00874d747dde814fa" # Ubuntu 20.04
}

// Tipo de instancia
variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.medium"
}

// Clave pública
variable "key_name" {
  description = "Nombre de la clave pública"
  type        = string
  default     = "vockey"
}

// Nombre de la instancia
variable "instance_frontend_name" {
  description = "Instance frontend"
  type        = string
  default     = "frontend"
}

variable "instance_backend_name" {
  description = "Instance backend"
  type        = string
  default     = "backend"
}