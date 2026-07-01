variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet 1 (AZ-a)"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet 2 (AZ-b)"
  type        = string
}

variable "private_app_subnet_1_cidr" {
  description = "CIDR for private app subnet 1 (AZ-a)"
  type        = string
}

variable "private_app_subnet_2_cidr" {
  description = "CIDR for private app subnet 2 (AZ-b)"
  type        = string
}

variable "private_db_subnet_1_cidr" {
  description = "CIDR for private DB subnet 1 (AZ-a)"
  type        = string
}

variable "private_db_subnet_2_cidr" {
  description = "CIDR for private DB subnet 2 (AZ-b)"
  type        = string
}

