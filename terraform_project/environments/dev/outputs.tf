output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}