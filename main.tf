terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
}

module "subnets" {
  source                    = "./modules/subnets"
  vpc_id                    = module.vpc.vpc_id
  project_name              = var.project_name
  region                    = var.region
  public_subnet_1_cidr      = var.public_subnet_1_cidr
  public_subnet_2_cidr      = var.public_subnet_2_cidr
  private_app_subnet_1_cidr = var.private_app_subnet_1_cidr
  private_app_subnet_2_cidr = var.private_app_subnet_2_cidr
  private_db_subnet_1_cidr  = var.private_db_subnet_1_cidr
  private_db_subnet_2_cidr  = var.private_db_subnet_2_cidr
}

module "nat_gateway" {
  source             = "./modules/nat_gateway"
  project_name       = var.project_name
  public_subnet_1_id = module.subnets.public_subnet_1_id
  public_subnet_2_id = module.subnets.public_subnet_2_id
  igw_id             = module.vpc.igw_id
}

module "route_tables" {
  source                  = "./modules/route_tables"
  vpc_id                  = module.vpc.vpc_id
  project_name            = var.project_name
  igw_id                  = module.vpc.igw_id
  nat_gw_1_id             = module.nat_gateway.nat_gw_1_id
  nat_gw_2_id             = module.nat_gateway.nat_gw_2_id
  public_subnet_1_id      = module.subnets.public_subnet_1_id
  public_subnet_2_id      = module.subnets.public_subnet_2_id
  private_app_subnet_1_id = module.subnets.private_app_subnet_1_id
  private_app_subnet_2_id = module.subnets.private_app_subnet_2_id
  private_db_subnet_1_id  = module.subnets.private_db_subnet_1_id
  private_db_subnet_2_id  = module.subnets.private_db_subnet_2_id
}

module "security_groups" {
  source       = "./modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "alb" {
  source                  = "./modules/alb"
  vpc_id                  = module.vpc.vpc_id
  project_name            = var.project_name
  alb_web_sg_id           = module.security_groups.alb_web_sg_id
  alb_app_sg_id           = module.security_groups.alb_app_sg_id
  public_subnet_1_id      = module.subnets.public_subnet_1_id
  public_subnet_2_id      = module.subnets.public_subnet_2_id
  private_app_subnet_1_id = module.subnets.private_app_subnet_1_id
  private_app_subnet_2_id = module.subnets.private_app_subnet_2_id
}

module "asg" {
  source                  = "./modules/asg"
  project_name            = var.project_name
  ami_id                  = data.aws_ami.amazon_linux_2023.id
  web_sg_id               = module.security_groups.web_sg_id
  app_sg_id               = module.security_groups.app_sg_id
  public_subnet_1_id      = module.subnets.public_subnet_1_id
  public_subnet_2_id      = module.subnets.public_subnet_2_id
  private_app_subnet_1_id = module.subnets.private_app_subnet_1_id
  private_app_subnet_2_id = module.subnets.private_app_subnet_2_id
  web_target_group_arn    = module.alb.web_target_group_arn
  app_target_group_arn    = module.alb.app_target_group_arn
}

module "bastion" {
  source             = "./modules/bastion"
  project_name       = var.project_name
  ami_id             = data.aws_ami.amazon_linux_2023.id
  public_subnet_1_id = module.subnets.public_subnet_1_id
  bastion_sg_id      = module.security_groups.bastion_sg_id
  bastion_public_key = var.bastion_public_key
}
module "rds" {
  source                 = "./modules/rds"
  project_name           = var.project_name
  private_db_subnet_1_id = module.subnets.private_db_subnet_1_id
  private_db_subnet_2_id = module.subnets.private_db_subnet_2_id
  db_sg_id               = module.security_groups.db_sg_id
  db_username            = var.db_username
  db_password            = var.db_password
}
