terraform {
    backend "s3" {
      bucket = "dinesh-terraform-state"   # "infrastructure-remote-state"
      key = "Terraform-Course/aws_project.tfstate"
      region = "us-east-1"
    }
}

provider "aws" {  # Recommended way of defining provider
    region = "us-east-1"
    shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
    // profile = "Dinesh-Tamang"
}

module "network_module" {
  source = "./network_module"
}

# importing load balancer module
module "loadbalancer_module" {
  source = "./loadbalancer_module"
  public_sg_id = "${module.network_module.public_sg_id}"
}