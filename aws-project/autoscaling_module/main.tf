# importing shared variable module
module "shared_vars" {
  source = "../shared_vars"
}

# creating a launch configuration for auto scaling
resource "aws_launch_configuration" "sampleapp_lc" {
  name = "sampleapp-lc-${local.env}"
  image_id = "${local.ami_id}"
  instance_type = "${local.instance_type}"
  key_name = "${local.keypair_name}"
  user_data = "${file("assets/userdata.sh")}"
  security_groups = ["${var.private_sg_id}"]
}

# auto scaling group
resource "aws_autoscaling_group" "sampleapp_asg" {
  name = "sample_app_sg_${local.env}"
  max_size = "${local.asg_max}"
  min_size = "${local.asg_min}"
  desired_capacity = "${local.asg_desired}"
  launch_configuration = "${aws_launch_configuration.sampleapp_lc.name}"
  vpc_zone_identifier = ["${module.shared_vars.public_subnet_id}"]
  target_group_arns = ["${var.target_group}"]

  tag {
      key = "Name"
      value = "Sample_app_${local.env}"
      propagate_at_launch = true
    }
  
  tag {
      key = "Environment"
      value = "Sample_app_${local.env}"
      propagate_at_launch = true
    }
}