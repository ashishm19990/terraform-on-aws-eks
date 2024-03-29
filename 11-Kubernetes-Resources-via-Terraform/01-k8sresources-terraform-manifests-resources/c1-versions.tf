# Terraform Settings Block
terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.43"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~>2.27"
    }
  }
  backend "s3" {
    region         = "us-east-1"
    bucket         = "terraform-tfdata"
    key            = "dev/eks-cluster/terraform.tfstate"
    dynamodb_table = "dev-ekscluster"
  }
}
