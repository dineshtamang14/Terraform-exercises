# creating a local variable
locals {
    env = "${terraform.workspace}"  # geting a current workspace
}