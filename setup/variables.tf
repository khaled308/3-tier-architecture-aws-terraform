variable "ami" {}
variable "instance_type" {}
# variable "key_name" {}
# variable "key_file_path" {}
# variable "security_group_id" {}
# variable "user_data" {}
# variable "tags" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {
    type = list
}
variable "private_subnet_cidr" {
    type = list
}

