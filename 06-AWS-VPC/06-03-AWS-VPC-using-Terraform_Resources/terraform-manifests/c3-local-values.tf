# Define Local Values in Terraform
locals {
  owners      = var.business_divsion
  Environment = terraform.workspace
  name        = "${var.business_divsion}-${terraform.workspace}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.Environment
  }
} 