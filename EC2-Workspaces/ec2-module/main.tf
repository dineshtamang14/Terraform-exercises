# creating key-pair for ec2 instance
resource "aws_key_pair" "keyPair" {
    key_name = "${var.create_keyPair == true ? "dovekey" : ""}"
    public_key = file("~/.ssh/dovekey.pub")
}

# creating ec2 instance
resource "aws_instance" "web" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.create_keyPair == true ? aws_key_pair.keyPair.key_name : "dovekey"}"
    vpc_security_group_ids = ["${var.sg_id}"]

    tags = {
        Name = "${var.ec2_name}"
    }
}