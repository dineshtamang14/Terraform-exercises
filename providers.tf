# configure aws provider
provider "aws" {
  region = var.REGION
}

# s3 bucket for storing terraform state
terraform {
  backend "s3" {
    bucket = "dinesh-terraform-state"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}