output "target_group" {
  value = "${aws_lb_target_group.sampleapp_http_tg.arn}"
  sensitive = false
  description = "target group arn"
  depends_on = []
}

output "lb_url" {
  value = "${aws_lb.sampleapp_alb.dns_name}"
  sensitive = false
  description = "application load balancer url"
  depends_on = []
}