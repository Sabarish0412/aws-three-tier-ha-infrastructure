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
