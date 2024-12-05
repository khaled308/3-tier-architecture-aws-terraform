resource "aws_lb" "alb" {
  name = var.alb_name
  load_balancer_type = "application"
  internal = false
  security_groups = [ var.alb_security_group_id ]
  subnets = var.alb_subnets
  enable_deletion_protection = true
}

resource "aws_lb_target_group" "alb_target_group" {
    name = var.alb_target_group_name
    port = var.alb_target_group_port
    protocol = var.alb_target_group_protocol
    target_type = var.alb_target_group_target_type
    vpc_id = var.vpc_id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = var.alb_listener_port
  protocol = var.alb_listener_protocol
  default_action {
    type = var.alb_listener_action_type
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}