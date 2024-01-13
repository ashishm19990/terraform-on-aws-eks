terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.31.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region  = var.aws_region
}