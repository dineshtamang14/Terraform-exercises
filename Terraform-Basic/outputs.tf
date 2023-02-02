# printing a string variable
output "myfirstOutput" {
    value = "${var.firstString}"
}

output "multilineString" {
    value = "${var.multiString}"
}

# printing map variable
output "mapOutput" {
    value = "${var.mapExample["useast"]}"
}

# printing list variable
output "listOutput" {
    value = "${var.mysecuritygrouplist[2]}"
}

# printing boolean variable
output "booloutput" {
    value = "${var.testbool}"
}

# printing user input data
output "myOutputVariable" {
    sensitive = true  # to hide sensitive data
    value = "${var.myInputVariable}"
}