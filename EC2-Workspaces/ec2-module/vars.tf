variable "ami" {
  type = string
  default = "ami-0aa7d40eeae50c9a9"
  description = "default ami"
}

# for taking a input from user or other module
variable "sg_id" {}

variable "ec2_name" {}

variable "create_keyPair" {}