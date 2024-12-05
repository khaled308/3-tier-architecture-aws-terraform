resource "aws_launch_configuration" "launch_config" {
  name            = var.name
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [var.security_group_id]
  user_data       = var.user_data

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = var.asg_name
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = var.asg_identifier_ids
  launch_configuration = aws_launch_configuration.launch_config.id
}

resource "aws_autoscaling_policy" "scale_out" {
    name = "scale_out"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
    name = "scale_in"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    autoscaling_group_name = aws_autoscaling_group.asg.name
}