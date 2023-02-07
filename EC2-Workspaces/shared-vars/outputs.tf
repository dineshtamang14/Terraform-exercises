output "env_suffix_output" {
    sensitive = false
    value = "${local.env_suffix}"
    description = "env specific ami id for ec2"
    depends_on = []
}