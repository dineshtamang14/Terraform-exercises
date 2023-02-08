# creating a launch configuration for auto scaling
resource "aws_launch_configuration" "sampleapp_lc" {
  name = "sampleapp-lc-${local.env}"
  image_id = "${local.ami_id}"
  instance_type = "${local.instance_type}"
  key_name = "${local.keypair_name}"
  user_data = "${file("assets/userdata.sh")}"
  security_groups = ["${var.private_sg_id}"]
}