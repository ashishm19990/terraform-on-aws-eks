# Terraform Settings Block
terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = "~> 5.45"
    }
  }
  backend "s3" {
    region = "us-east-1"
    bucket = "terraform-tfdata"
    key    = "dev/eks-cluster/terraform.tfstate"

    # For State Locking
    dynamodb_table = "dev-ekscluster"
  }
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}
