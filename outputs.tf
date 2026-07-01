output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  description = "ID of public subnet 1"
  value       = module.subnets.public_subnet_1_id
}

output "public_subnet_2_id" {
  description = "ID of public subnet 2"
  value       = module.subnets.public_subnet_2_id
}

output "private_app_subnet_1_id" {
  description = "ID of private app subnet 1"
  value       = module.subnets.private_app_subnet_1_id
}

output "private_app_subnet_2_id" {
  description = "ID of private app subnet 2"
  value       = module.subnets.private_app_subnet_2_id
}

output "private_db_subnet_1_id" {
  description = "ID of private DB subnet 1"
  value       = module.subnets.private_db_subnet_1_id
}

output "private_db_subnet_2_id" {
  description = "ID of private DB subnet 2"
  value       = module.subnets.private_db_subnet_2_id
}

output "nat_gw_1_id" {
  description = "ID of NAT Gateway 1"
  value       = module.nat_gateway.nat_gw_1_id
}

output "nat_gw_2_id" {
  description = "ID of NAT Gateway 2"
  value       = module.nat_gateway.nat_gw_2_id
}
