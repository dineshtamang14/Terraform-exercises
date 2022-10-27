# jenkins server setup
resource "aws_instance" "jenkins" {
  ami               = var.AMIS["ubuntu18"]
  instance_type     = "t2.small"
  count             = 1
  availability_zone = "us-east-1a"
  key_name          = "vprofile-prod-key"
  vpc_security_group_ids = [
    "sg-0eb600aa6ac4e7b1e"
  ]
  user_data = file("./userdata/jenkins-setup.sh")
  tags = {
    Name = "Jenkins-server"
  }
}

resource "aws_instance" "vms-servers" {
  for_each = toset(var.VMS)
  name = each.value
  ami               = var.AMIS[name]
  instance_type     = name == jenkins ? "t2.small" : "t2.medium"
  count             = 1
  availability_zone = "us-east-1a"
  key_name          = "vprofile-prod-key"
  vpc_security_group_ids = [
    "${var.SG[name]}"
  ]
  user_data = file("./userdata/${name}-setup.sh")
  tags = {
    Name = "${name}-server"
  }
}

# nexus server setup
resource "aws_instance" "nexus" {
  ami               = var.AMIS["centos"]
  instance_type     = "t2.medium"
  count             = 1
  availability_zone = "us-east-1a"
  key_name          = "vprofile-prod-key"
  vpc_security_group_ids = [
    "sg-0917059ab4119fad2"
  ]
  user_data = file("./userdata/nexus-setup.sh")
  tags = {
    Name = "nexus-server"
  }
}

# sonar server setup
resource "aws_instance" "sonar" {
  ami               = var.AMIS["ubuntu"]
  instance_type     = "t2.medium"
  count             = 1
  availability_zone = "us-east-1a"
  key_name          = "vprofile-prod-key"
  vpc_security_group_ids = [
    "sg-0e3d6a4e659198775"
  ]
  user_data = file("./userdata/sonar-setup.sh")
  tags = {
    Name = "sonar-server"
  }
}

output "PublicIP" {
  value       = "jenkins ip: ${aws_instance.jenkins[0].public_ip} sonar ip: ${aws_instance.sonar[0].public_ip}, nexus ip: ${aws_instance.nexus[0].public_ip}"
  description = "PublicIP address details"
}