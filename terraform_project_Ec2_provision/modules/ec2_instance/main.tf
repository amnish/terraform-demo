resource "tls_private_key" "ec2_conn" {
  algorithm = "RSA"
  
}

resource "aws_key_pair" "ec2_conn" {
  key_name   = "ec2_conn"
  public_key = tls_private_key.ec2_conn.public_key_openssh
}



output "private_key_pem" {
  value     = tls_private_key.ec2_conn.private_key_pem
  sensitive = true
}
resource "local_file" "private_key" {
  content  = tls_private_key.ec2_conn.private_key_pem
  filename = "${path.module}/ec_conn.pem"
}

resource "aws_instance" "ec2_test" {
    ami = var.ami_name
    instance_type = var.instance_type_value
    subnet_id = var.subnet_id_value
    vpc_security_group_ids = [aws_security_group.sg_ec2.id]
    key_name = aws_key_pair.ec2_conn.key_name
    associate_public_ip_address = true
  
}
resource "aws_security_group" "sg_ec2" {
  name        = "sg"
  description = "Allow  inbound traffic and all outbound traffic"

  tags = {
    Name = "sg_ec2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sg_ec2_ipv4" {
  description = "whitlisting ssh conection"
  security_group_id = aws_security_group.sg_ec2.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "http_connection" {
  security_group_id = aws_security_group.sg_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  description = "whitlisting http conection"
  security_group_id = aws_security_group.sg_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.sg_ec2.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}