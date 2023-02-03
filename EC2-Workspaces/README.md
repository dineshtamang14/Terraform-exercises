# Terraform module

# To use project as a module

module "ec2_module" {
    source = "./ec2_module"
}

# always initiate the module after importing it
`terraform init`