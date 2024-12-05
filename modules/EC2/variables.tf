variable "ami" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "key_name" {
    type = string
}

variable "key_file_path" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "security_group_id" {
    type = string
}

variable "associate_public_ip_address" {
    type = bool
}

variable "user_data" {
    type = string
}

variable "tags" {
    type = map(string)
}
