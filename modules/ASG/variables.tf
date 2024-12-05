variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "user_data" {
  type = string
}

variable "name" {
  type = string
}

variable "asg_identifier_ids" {
  type = list(any)
}

variable "asg_name" {
  type = string
}

variable "target_group_arns" {
  type = list(string)
}