data "aws_availability_zones" "azs" {}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_subnets" {
  type    = list
  default = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
}

variable "bastion_subnets" {
  type    = list
  default = ["10.0.8.0/24"]
}

variable "nat_gw_subnets" {
  type    = list
  default = ["10.0.9.0/24"]
}

variable "env" {
  type = string
}

variable "project" {
  type    = string
  default = "Demo"
}

