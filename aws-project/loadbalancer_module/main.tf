# importing shared variable module
module "shared_vars" {
  source = "../shared_vars"
}

# creating a application ELB
resource "aws_lb" "sampleapp_alb" {
  name = "sampleapp_alb_${module.shared_vars.env_suffix}"
  internal = false
  load_balancer_type = "application"
  security_groups = ["private_sg"]
  subnets = ["subnet-02d7d3fc9888b1735"]

  enable_deletion_protection = true

  access_logs = {
    bucket = ""
    prefix = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "Production"
  }
}