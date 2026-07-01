variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
}

variable "igw_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

variable "nat_gw_1_id" {
  description = "ID of NAT Gateway 1 (AZ-a)"
  type        = string
}

variable "nat_gw_2_id" {
  description = "ID of NAT Gateway 2 (AZ-b)"
  type        = string
}

variable "public_subnet_1_id" {
  description = "ID of public subnet 1"
  type        = string
}

variable "public_subnet_2_id" {
  description = "ID of public subnet 2"
  type        = string
}

variable "private_app_subnet_1_id" {
  description = "ID of private app subnet 1 (AZ-a)"
  type        = string
}

variable "private_app_subnet_2_id" {
  description = "ID of private app subnet 2 (AZ-b)"
  type        = string
}

variable "private_db_subnet_1_id" {
  description = "ID of private DB subnet 1 (AZ-a)"
  type        = string
}

variable "private_db_subnet_2_id" {
  description = "ID of private DB subnet 2 (AZ-b)"
  type        = string
}
