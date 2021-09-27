output "vpc_id" {
  value = "${module.main_vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.main_vpc.vpc_cidr}"
}

output "private_subnets" {
  value = "${module.main_vpc.private_subnets}"
}

output "public_subnets" {
  value = "${module.main_vpc.public_subnets}"
}

output "bastion_subnets" {
  value = "${module.main_vpc.bastion_subnets}"
}

output "db_subnets" {
  value = "${module.main_vpc.db_subnets}"
}

output "public_subnet_cidr" {
  value = "${module.main_vpc.public_subnet_cidr}"
}

output "bastion_subnet_cidr" {
  value = "${module.main_vpc.bastion_subnet_cidr}"
}


output "db_subnet_cidr" {
  value = "${module.main_vpc.db_subnet_cidr}"
}

output "private_subnet_cidr" {
  value = "${module.main_vpc.private_subnet_cidr}"
}

output "pvt_acl_id" {
  value = "${module.main_vpc.pvt_acl_id}"
}

output "pub_acl_id" {
  value = "${module.main_vpc.pub_acl_id}"
}

output "bastion_acl_id" {
  value = "${module.main_vpc.bastion_acl_id}"
}

output "db_acl_id" {
  value = "${module.main_vpc.db_acl_id}"
}

output "nat_gw_acl_id" {
  value = "${module.main_vpc.nat_gw_acl_id}"
}

output "lb-security_group" {
  value = "${module.security_groups.lb-security_group}"
}

output "bastion-security_group" {
  value = "${module.security_groups.bastion-security_group}"
}




output "ec2-security_group" {
  value = "${module.security_groups.ec2-security_group}"
}

output "ec2-db-security_group" {
  value = "${module.security_groups.ec2-db-security_group}"
}





