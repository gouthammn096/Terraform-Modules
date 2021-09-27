output "vpc_id" {
  value = "${aws_vpc.main_vpc.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.main_vpc.cidr_block}"
}

output "private_subnets" {
  value = "${aws_subnet.private_subnet[*].id}"
}

output "public_subnets" {
  value = "${aws_subnet.public_subnet[*].id}"
}

output "bastion_subnets" {
  value = "${aws_subnet.bastion_subnet[*].id}"
}

output "db_subnets" {
  value = "${aws_subnet.db_subnet[*].id}"
}

output "nat_gw_subnets" {
  value = "${aws_subnet.nat_gw_subnet[*].id}"
}



output "public_subnet_cidr" {
  value = "${aws_subnet.public_subnet[*].cidr_block}"
}

output "bastion_subnet_cidr" {
  value = "${aws_subnet.bastion_subnet[*].cidr_block}"
}

output "db_subnet_cidr" {
  value = "${aws_subnet.db_subnet[*].cidr_block}"
}

output "nat_gw_subnet_cidr" {
  value = "${aws_subnet.nat_gw_subnet[*].cidr_block}"
}


output "private_subnet_cidr" {
  value = "${aws_subnet.private_subnet[*].cidr_block}"
}

output "pvt_acl_id" {
  value = "${aws_network_acl.acl_private_subnet.id}"
}

output "pub_acl_id" {
  value = "${aws_network_acl.acl_public_subnet.id}"
}

output "bastion_acl_id" {
  value = "${aws_network_acl.acl_bastion_subnet.id}"
}


output "db_acl_id" {
  value = "${aws_network_acl.acl_db_subnet.id}"
}


output "nat_gw_acl_id" {
  value = "${aws_network_acl.acl_nat_gw_subnet.id}"
}
