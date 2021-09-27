
### Main VPC ###

resource "aws_vpc" "main_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "${var.project}-${var.env}-VPC"
  }
}

### Subnets ###

resource "aws_subnet" "bastion_subnet" {
  count                   = 1
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "${element(var.bastion_subnets, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.azs.names, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.env}-spub-bastion-${count.index + 1}"
  }
}

resource "aws_subnet" "nat_gw_subnet" {
  count                   = 1
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "${element(var.nat_gw_subnets, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.azs.names, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.env}-spub-nat-${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "${element(var.public_subnets, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.azs.names, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.env}-spub-lb-${count.index + 1}"
  }
}
resource "aws_subnet" "private_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "${element(var.private_subnets, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.azs.names, count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project}-${var.env}-spvt-app-${count.index + 1}"
  }
}

resource "aws_subnet" "db_subnet" {
  count                   = "${length(data.aws_availability_zones.azs.names)}"
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  cidr_block              = "${element(var.db_subnets, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.azs.names, count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project}-${var.env}-spvt-db-${count.index + 1}"
  }
}

### Elastic IP ###

resource "aws_eip" "nat_gw_ip" {
  vpc = true
}

###  Gateway ###

resource "aws_internet_gateway" "main_igw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "${var.project}-${var.env}-IGW"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_gw_ip.id}"
  subnet_id     = "${aws_subnet.nat_gw_subnet[0].id}"
  tags = {
    Name = "${var.project}-${var.env}-nat_gw"
  }
}

### Route Tables ###

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_igw.id}"
  }
  tags = {
    Name = "${var.project}-${var.env}-rt"
  }
}

resource "aws_route_table" "nat_gw_route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }
  tags = {
    Name = "${var.project}-${var.env}-nat-rt"
  }
}

### Route table Associations ###

resource "aws_route_table_association" "public_route_association1" {
  count          = 2
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "public_route_association2" {
  count          = 1
  subnet_id      = "${element(aws_subnet.bastion_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "nat_gw_route_association1" {
  count          = 2
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.nat_gw_route_table.id}"
}



### ACL ####

resource "aws_network_acl" "acl_public_subnet" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.public_subnet[0].id}", "${aws_subnet.public_subnet[1].id}"]

  tags = {
    Name = "${var.project}-${var.env}-lb-acl"
  }
}

resource "aws_network_acl" "acl_bastion_subnet" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.bastion_subnet[0].id}"]

  tags = {
    Name = "${var.project}-${var.env}-bastion-acl"
  }
}

resource "aws_network_acl" "acl_nat_gw_subnet" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.nat_gw_subnet[0].id}"]

  tags = {
    Name = "${var.project}-${var.env}-nat_gw-acl"
  }
}


resource "aws_network_acl" "acl_private_subnet" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.private_subnet[0].id}", "${aws_subnet.private_subnet[1].id}"]

  tags = {
    Name = "${var.project}-${var.env}-app-acl"
  }
}

resource "aws_network_acl" "acl_db_subnet" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.db_subnet[0].id}", "${aws_subnet.db_subnet[1].id}", "${aws_subnet.db_subnet[2].id}"]

  tags = {
    Name = "${var.project}-${var.env}-db-acl"
  }
}

