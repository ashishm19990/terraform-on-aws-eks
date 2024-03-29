# Terraform Settings Block
terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = "~> 5.43"          
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.7"
      version = ">= 2.27"
    }    
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-tfdata"
    key    = "dev/app1k8s/terraform.tfstate"
    region = "us-east-1" 

    # For State Locking
    dynamodb_table = "dev-app1k8s"    
  }     
}
