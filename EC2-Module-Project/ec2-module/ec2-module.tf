# security group creation for ec2 instance 
resource "aws_security_group" "terraform_ec2_sg" {
    name = "terraform_sg"
    description = "allowing only ssh"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "terraform-sg"
    }
}

# creating key-pair for ec2 instance
resource "aws_key_pair" "keyPair" {
    key_name = "dovekey"
    public_key = file("~/.ssh/dovekey.pub")
}

# creating ec2 instance
resource "aws_instance" "web" {
    ami = var.ami
    instance_type = "t2.micro"
    key_name = aws_key_pair.keyPair.key_name
    vpc_security_group_ids = [aws_security_group.terraform_ec2_sg.id]

    tags = {
        Name = "terraform-instance"
    }
}