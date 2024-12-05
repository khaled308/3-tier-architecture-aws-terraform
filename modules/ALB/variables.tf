variable "alb_name" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "alb_subnets" {
  type = list(string)
}

variable "alb_target_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "alb_target_group_port" {
    type = number
}

variable "alb_target_group_protocol" {
    type = string
}

variable "alb_target_group_target_type" {
    type = string
}

variable "alb_listener_port" {
  type = number
}

variable "alb_listener_protocol" {
  type = string
}

variable "alb_listener_action_type" {
  type = string
}