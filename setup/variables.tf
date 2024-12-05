variable "ami" {}
variable "instance_type" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {
    type = list
}
variable "private_subnet_cidr" {
    type = list
}
