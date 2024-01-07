# Terraform Settings Block
terraform {
  required_version = ">= 1.6.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 3.63"
      version = ">= 5.31"
    }
  }
}

# Terraform Provider Block
provider "aws" {
  region = "us-east-1"
}