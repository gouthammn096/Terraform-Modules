resource "aws_security_group" "lb-sg" {
  description = "Allow inbound traffic for LB"
  vpc_id      = "${var.vpc}"
  tags = {
    Name = "${var.project}-${var.env}-lb-sg"
  }
}

resource "aws_security_group" "bastion-sg" {
  description = "Allow ssh traffic for bastion host"
  vpc_id      = "${var.vpc}"
  tags = {
    Name = "${var.project}-${var.env}-bastion-sg"
  }
}

resource "aws_security_group" "ec2-sg" {
  description = "Allow  http traffic to ec2 nodes "
  vpc_id      = "${var.vpc}"
  tags = {
    Name = "${var.project}-${var.env}-asg-sg"
  }
}

resource "aws_security_group" "db-sg" {
  description = "Allow as instances to connect to db"
  vpc_id      = "${var.vpc}"
  tags = {
    Name = "${var.project}-${var.env}-db-sg"
  }
}





