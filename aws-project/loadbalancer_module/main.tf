# importing shared variable module
module "shared_vars" {
  source = "../shared_vars"
}

# creating a application ELB
resource "aws_lb" "sampleapp_alb" {
  name = "sampleapp-alb-${module.shared_vars.env_suffix}"
  internal = false
  load_balancer_type = "application"
  security_groups = ["${var.public_sg_id}"]
  subnets = ["${module.shared_vars.public_subnet_id}", "subnet-02d7d3fc9888b1735"]

  enable_deletion_protection = true

  tags = {
    Environment = "${module.shared_vars.env_suffix}"
  }
}


# creating a target group for load balancer
resource "aws_lb_target_group" "sampleapp_http_tg" {
  name = "sampleapp-http-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = "${module.shared_vars.vpcid}"
}

# creating a aws load balancer listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = "${aws_lb.sample_alb.arn}"
  port = "80"
  protocol = "HTTP"
  ssl_policy = "ELBSecurityPolicy-2015-05"

  default_action {
    type = "forward"
    target_groupt_arn = "${aws_lb_target_group.front_end.arn}"
  }
}