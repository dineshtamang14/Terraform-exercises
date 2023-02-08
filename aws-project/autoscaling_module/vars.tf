locals {
    env = "${terraform.workspace}"
    
    ami_id_env = {
    default = "ami-0aa7d40eeae50c9a9"
    staging = "ami-0aa7d40eeae50c9a9"
    production = "ami-0aa7d40eeae50c9a9"
  }

  ami_id = "${lookup(local.ami_id_env, local.env)}"

  instance_type_env = {
    default = "t2.micro"
    staging = "t2.micro"
    production = "t2.small"
  }

  instance_type = "${lookup(local.instance_type_env, local.env)}"

  keypair_name_env = {
    default = "vprofile-prod-key"
    staging = "vprofile-prod-key"
    production = "vprofile-prod-key"
  }

  keypair_name = "${lookup(local.keypair_name_env, local.env)}"

  asg_desired_env = {
    default = 1
    staging = 1
    production = 2
  }

  asg_desired = "${lookup(local.asg_desired_env, local.env)}"

  asg_max_env = {
    default = 2
    staging = 2
    production = 2
  }

  asg_max = "${lookup(local.asg_max_env, local.env)}"

  asg_min_env = {
    default = 1
    staging = 1
    production = 1
  }

  asg_min = "${lookup(local.asg_min_env, local.env)}"
}

variable "private_sg_id" {}
variable "target_group" {}