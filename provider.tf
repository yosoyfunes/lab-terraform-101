terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }
}

# This file configures the AWS provider for Terraform.
provider "aws" {
  region = var.region
}