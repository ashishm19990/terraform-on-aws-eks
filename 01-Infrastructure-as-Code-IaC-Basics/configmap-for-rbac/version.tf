# Terraform Settings Block
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.43"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 3.4"
    }
  }
}

# Terraform AWS Provider Block
provider "aws" {
  region = "us-east-1"
}

# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}

