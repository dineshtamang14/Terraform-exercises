output "alb_url" {
    value = "${module.loadbalancer_module.lb_url}"
    sensitive = false
    description = "application load balancer dns url"
    depends_on = []
}