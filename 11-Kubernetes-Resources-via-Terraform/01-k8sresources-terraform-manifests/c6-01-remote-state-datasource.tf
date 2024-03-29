# Terraform Remote State Datasource
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    region         = "us-east-1"
    bucket         = "terraform-tfdata"
    key            = "dev/terraform.tfstate"
   }
}

