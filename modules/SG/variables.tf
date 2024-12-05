variable "sg_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "ingress" {
    type = list(map)
}

variable "egress" {
    type = list(map)
}