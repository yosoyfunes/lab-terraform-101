output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.lab_ec2.public_ip
}

output "http_url" {
  description = "URL para acceder por HTTP"
  value       = "http://${aws_instance.lab_ec2.public_ip}"
}
