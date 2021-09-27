provider "aws" {
  region = ""
}

module "main_vpc" {
  source          = "../modules/networking"
  env             = "${var.env}"
  project         = "${var.project}"
  vpc_cidr        = "${var.vpc_cidr}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
  db_subnets      = "${var.db_subnets}"
  bastion_subnets = "${var.bastion_subnets}"
  nat_gw_subnets  = "${var.nat_gw_subnets}"
}

module "security_groups" {
  source  = "../modules/sg"
  vpc     = "${module.main_vpc.vpc_id}"
  env     = "${var.env}"
  project = "${var.project}"
}
