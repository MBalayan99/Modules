provider "aws" {
  region = var.region
}

module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = "MyVPC"
  igw_name = "MyIGW"
}

module "network" {
  source             = "./network"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_name = "Public Subnet"
  private_subnet_name = "Private Subnet"
  az                 = var.az
  nat_name           = "MyNAT"
}

module "alb" {
  source          = "./alb"
  vpc_id          = module.vpc.vpc_id
  public_subnet_id = module.network.public_subnet_id
  alb_sg_id       = aws_security_group.alb_sg.id
}

module "asg" {
  source           = "./asg"
  ami              = var.ami
  instance_type    = var.instance_type
  key_name         = var.key_name
  private_subnet_id = module.network.private_subnet_id
  instance_sg_id   = aws_security_group.instance_sg.id
  target_group_arn = module.alb.app_tg_arn
}
