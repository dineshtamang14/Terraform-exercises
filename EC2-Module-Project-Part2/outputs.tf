# ec2 instance 1 public ip output
output "ec2_public_ip_1" {
    value = "instance 1: ${module.ec2_module_1.ec2-public-ip}"
    sensitive = false
    description = "Public IP of ec2 instanc"
    depends_on = []
}


# ec2 instance 2 public ip output
output "ec2_public_ip_2" {
    value = "instance 2: ${module.ec2_module_2.ec2-public-ip}"
    sensitive = false
    description = "Public IP of ec2 instanc"
    depends_on = []
}
