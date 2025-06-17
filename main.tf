# vpc
resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "lab-vpc"
  }
}

# Subnet
resource "aws_subnet" "lab_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags = {
    Name = "lab-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = {
    Name = "lab-igw"
  }
}

# Route Table
resource "aws_route_table" "lab_rt" {
  vpc_id = aws_vpc.lab_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }
  tags = {
    Name = "lab-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "lab_rt_assoc" {
  subnet_id      = aws_subnet.lab_subnet.id
  route_table_id = aws_route_table.lab_rt.id
}

# Security Group
resource "aws_security_group" "lab_sg" {
  name        = "lab-sg"
  description = "Permite acceso HTTP"
  vpc_id      = aws_vpc.lab_vpc.id

  tags = {
    Name = "lab-sg"
  }
}

# Security Group Rules Ingress
resource "aws_security_group_rule" "lab_sg_ingress_ssh" {
  # Permite acceso SSH desde la VPC
  # Esto es útil para acceder a la instancia EC2 desde la misma VPC
  # o desde una VPN conectada a la VPC.
  # Si queremos permitir el acceso desde cualquier IP, se puede cambiar
  # cidr_blocks a ["0.0.0.0/0"]
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.lab_vpc.cidr_block]
  security_group_id = aws_security_group.lab_sg.id
}

# Security Group Rules Egress
resource "aws_security_group_rule" "lab_sg_egress_all" {
  # Permite todo el tráfico de salida
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lab_sg.id
}

# EC2 Instance
resource "aws_instance" "lab_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.lab_subnet.id
  vpc_security_group_ids      = [aws_security_group.lab_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "lab-ec2"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hola desde Terraform" > /var/www/html/index.html
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              EOF
}
