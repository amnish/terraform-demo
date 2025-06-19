output "public-ip-address" {
    value = aws_instance.ec2_test.public_ip
}