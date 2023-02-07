# ec2 instance 1 public ip output
output "ec2_public_ip_1" {
    value = "instance 1: ${module.ec2_module_1.ec2-public-ip}"
    sensitive = false
    description = "Public IP of ec2 instanc"
    depends_on = []
}

output "envspecificoutput_variable" {
    sensitive = false
    value = "${local.amiid}"
    description = "env specific ami id for ec2"
    depends_on = []
}