output "frontend_ip" {
  value = aws_eip.ip_elastica_backend.public_ip
}

output "backend_ip" {
  value = aws_eip.ip_elastica_frontend.public_ip
}