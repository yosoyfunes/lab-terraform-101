variable "region" {
  description = "Región donde desplegar la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI de Amazon Linux 2"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}
