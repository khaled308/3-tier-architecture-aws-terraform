output "load_balancer_dns_name" {
  description = "LoadBalancer dns name"
  value = aws_lb.alb.dns_name
}

output "alb_target_group_arn" {
  description = "ALB Target Grouparn"
  value = aws_lb_target_group.alb_target_group.arn
}