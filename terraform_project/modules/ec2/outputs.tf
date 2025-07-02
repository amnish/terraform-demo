output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
output "key_pair_name" {
  value = aws_key_pair.key_pair.key_name
  
}