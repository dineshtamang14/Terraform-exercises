# importing module of shared variable
module "shared_vars" {
  source = "../shared_vars"
}

# security group creation for application Load Balancer
resource "aws_security_group" "public_sg" {
    name = "public_sg_${module.shared_vars.env_suffix}"
    description = "public sg for ELB in ${module.shared_vars.env_suffix}"
    vpc_id = "${module.shared_vars.vpcid}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "application_load_balancer_sg"
    }
}

# security group creation for ec2 instance 
resource "aws_security_group" "private_sg" {
    name = "private_sg_${module.shared_vars.env_suffix}"
    description = "private sg for EC2 Instance in ${module.shared_vars.env_suffix}"
    vpc_id = "${module.shared_vars.vpcid}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.public_sg.id}"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "aws_ec2_sg"
    }
}