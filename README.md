# Laboratorio Terraform: Infraestructura Básica en AWS

## Objetivo

Crear una infraestructura mínima en AWS utilizando Terraform

## Recursos a crear

- VPC
- Subred pública
- Internet Gateway
- Tabla de rutas
- Security Group (puerto 80)
- Instancia EC2 (Amazon Linux 2) con un servidor web básico

## Requisitos

- Terraform instalado
- AWS CLI configurado

## Instrucciones

1. Ejecutar `terraform init`
2. Ejecutar `terraform apply`
3. Acceder a la IP pública mostrada en la salida (`http_url`) para verificar el contenido servido

**Nota:** Este laboratorio no requiere conectarse a la instancia, está diseñado para practicar la creación de recursos básicos.
