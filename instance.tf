# jenkins server setup
resource "aws_instance" "vms-servers" {
  for_each          = toset(var.VMS)
  ami               = var.AMIS[each.key]
  instance_type     = each.key != "jenkins" ? "t2.medium": "t2.small"
  availability_zone = "us-east-1a"
  key_name          = "vprofile-prod-key"
  vpc_security_group_ids = [
    "${var.SG[each.key]}"
  ]
  user_data = file("./userdata/${each.key}-setup.sh")
  tags = {
    Name = "${each.key}-server"
  }
}

output "PublicIP" {
  for_eah = toset(var.VMS)
  value       = "${each.key} ip: ${aws_instance.vms-servers[each.key].public_ip}"
  description = "PublicIP address details"
}