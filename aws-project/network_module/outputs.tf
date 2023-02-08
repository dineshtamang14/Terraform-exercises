# outputing public security group id
output "public_sg_id" {
    value = "${aws_security_group.public_sg.id}"
    description = "public security group id"
    depends_on = []
}

# outputing private security group id
output "private_sg_id" {
    value = "${aws_security_group.private_sg.id}"
    description = "private security group id"
    depends_on = []
}