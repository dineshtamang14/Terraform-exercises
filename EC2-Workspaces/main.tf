terraform {
    backend "s3" {
      bucket = "dinesh-terraform-state"   # "infrastructure-remote-state"
      key = "Terraform-Course/ec2.tfstate"
      region = "us-east-1"
    }
}

provider "aws" {  # Recommended way of defining provider
    region = "us-east-1"
    shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
    // profile = "Dinesh-Tamang"
}

# importing sg module
module "sg_module" {
    source = "./sg-module"
}


# importing ec2 instance module
# instance 1
module "ec2_module_1" {
    source = "./ec2-module/"
    # supplying a input from other module
    sg_id = "${module.sg_module.sg_id_output}"
    create_keyPair = true
}