# this is a string variable
variable "firstString" {
    type = string
    default = "this is my first string"
}

variable "multiString" {
    type = string
    default = <<EOF
        this is the multistring 
        variable
    EOF
}

# this is map variable
variable "mapExample" {
    type = map
    default = {
        "useast" = "ami1"
        "euwest" = "ami2"
    }
}

# arrays/lists variable
variable "mysecuritygrouplist" {
    type = list
    default = ["sg1", "sg2", "sg3", "sg4"]
}

# boolean variable 
variable "testbool" {
    default = true
}

# taking input from user and storing it in variable
variable "myInputVariable" {
    type = string
}