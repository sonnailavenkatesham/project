resource "aws_security_group" "all_TCP" {
  name        = "Allow_all_Ports"
  description = "allowing all ports form outside"
  tags = {
    Name = "${var.project}-${var.ENV}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_TCP" {
  security_group_id = aws_security_group.all_TCP.id
  from_port         = 0
  to_port           = 65535
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "all_ports" {
  security_group_id = aws_security_group.all_TCP.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}