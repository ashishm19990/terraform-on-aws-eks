# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.31.0"
    }
  }
}

# Terraform Provider Block
provider "aws" {
  profile = "default"
  region  = var.aws_region
}