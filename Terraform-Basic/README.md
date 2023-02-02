# For setting up the aws cli
1. `sudo apt install awscli -y`
2. `aws configure --profile Dinesh-Tamang` # setting up aws profile with name


# Variables in Terraform
Supported Types
1. strings
Examples:
    variable "key" {
        type = string
        default = "value"
    }

    variable "MultiString" {
        type = string
        default = <<EOF
            This is a multiline
            string
        EOF
    }

2. Maps
Examples:
    variable "mapExample" {
        type = map
        default = {
            "useast" = "ami-1"
            "Euwest" = "ami-2"
        }
    }
    
3. Lists
Examples:
    variable "listExample" {
        type = list
        default = ["sg1", "sg2", "sg3"]
    }

4. Booleans
Examples:
    variable "testbool" {
        default = true
    }


# taking input from user and storing it in variable
variable "userInput" {
    type = string
}

output "userInputOutput" {
    sensitive = true   # to hide sensitive data
    value = "${var.userInput}"
}