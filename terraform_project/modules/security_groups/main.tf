resource "aws_security_group" "dev-ex" {
  name   = "dev-ex"
  vpc_id = var.vpc_id
  tags = {
    Name = "dev-ex"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.dev-ex.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.dev-ex.id
  ip_protocol       = "tcp"
  from_port         = 8080
  to_port           = 8080
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "dev-alb" {
  name   = "dev-alb"
  vpc_id = var.vpc_id
  tags = {
    Name = "dev-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-alb" {
  security_group_id = aws_security_group.dev-alb.id
  ip_protocol       = "tcp"
  from_port         = 8080
  to_port           = 8080
  cidr_ipv4         = "0.0.0.0/0"
}