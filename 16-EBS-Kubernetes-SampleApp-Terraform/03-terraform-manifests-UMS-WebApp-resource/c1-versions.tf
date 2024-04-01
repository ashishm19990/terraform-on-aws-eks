# Terraform Settings Block
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = "~> 5.43"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.7.1"
      version = ">= 2.27"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-tfdata"
    key    = "dev/ebs-sampleapp-demo/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-ebs-sampleapp-demo"
  }
}

