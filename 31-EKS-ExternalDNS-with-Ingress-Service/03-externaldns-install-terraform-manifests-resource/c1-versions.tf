# Terraform Settings Block
terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = "~> 5.44"
    }
    helm = {
      source = "hashicorp/helm"
      #version = "2.5.1"
      #version = "~> 2.5"
      version = "~> 2.13"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.11"
      version = "~> 2.29"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-tfdata"
    key    = "dev/aws-externaldns/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-aws-externaldns"
  }
}

# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

