data "aws_availability_zones" "azs" {}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list
}

variable "private_subnets" {
  type = list
}

variable "db_subnets" {
  type = list
}

variable "bastion_subnets" {
  type = list
}

variable "nat_gw_subnets" {
  type = list
}

variable "env" {
  type = string
}

variable "project" {
  type = string
}


