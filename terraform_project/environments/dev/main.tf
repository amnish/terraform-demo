module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = local.vpc_cidr
}

module "subnets" {
  source     = "../../modules/subnets"
  vpc_id     = module.vpc.vpc_id
  vpc_cidr   = local.vpc_cidr
  az_count   = local.az_count
}

module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "../../modules/ec2"
  ami_value          = local.ami
  vpc_id            = module.vpc.vpc_id
  instance_type     = local.instance_type
  public_subnet_id  = module.subnets.public_subnet_ids[0]
}

module "alb" {
  source            = "../../modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  dev_alb_id     = module.security_groups.dev_alb_id
}

module "autoscaling" {
  source             = "../../modules/autoscaling"
  ami                = local.ami
  instance_type      = local.instance_type
  dev_ex_id      = module.security_groups.dev_ex_id
  key_name           = module.ec2.key_pair_name
  private_subnet_ids = module.subnets.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  az_count           = local.az_count
}