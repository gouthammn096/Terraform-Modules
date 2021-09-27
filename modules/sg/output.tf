output "lb-security_group" {
  value = "${aws_security_group.lb-sg.id}"
}

output "bastion-security_group" {
  value = "${aws_security_group.bastion-sg.id}"
}


output "ec2-security_group" {
  value = "${aws_security_group.ec2-sg.id}"
}

output "ec2-db-security_group" {
  value = "${aws_security_group.db-sg.id}"
}

