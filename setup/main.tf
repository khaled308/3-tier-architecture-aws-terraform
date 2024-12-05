terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "../modules/VPC"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "alb_sg" {
  source = "../modules/SG"
  vpc_id = module.vpc.vpc_id
  sg_name = "alb-sg"
  ingress = [
    {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "public_instance_sg" {
  source = "../modules/SG"
  vpc_id = module.vpc.vpc_id
  sg_name = "public-instance-sg"
  ingress = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "private_instance_sg" {
  source = "../modules/SG"
  vpc_id = module.vpc.vpc_id
  sg_name = "private-instance-sg"
  ingress = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "alb" {
  source = "../modules/ALB"
  alb_name = "alb"
  alb_security_group_id = module.alb_sg.sg_id
  alb_subnets = module.vpc.public_subnet_ids
  alb_target_group_name = "alb-tg"
  vpc_id = module.vpc.vpc_id
  alb_target_group_port = 80
  alb_target_group_protocol = "HTTP"
  alb_target_group_target_type = "ip"
  alb_listener_port = 80
  alb_listener_protocol = "HTTP"
  alb_listener_action_type = "forward"
}

module "public_asg" {
  source = "../modules/ASG"
  name = "public-asg"
  ami = var.ami
  instance_type = var.instance_type
  security_group_id = module.public_instance_sg.sg_id
  user_data = "echo hi"
  asg_identifier_ids = module.vpc.public_subnet_ids
  asg_name = "public-asg"
  target_group_arns = [module.alb.alb_target_group_arn]
}

module "private_asg" {
  source = "../modules/ASG"
  name = "private-asg"
  ami = var.ami
  instance_type = var.instance_type
  security_group_id = module.private_instance_sg.sg_id
  user_data = "echo hi"
  asg_identifier_ids = slice(module.vpc.private_subnet_ids, 0, 2)
  asg_name = "private-asg"
  target_group_arns = [module.alb.alb_target_group_arn]
}