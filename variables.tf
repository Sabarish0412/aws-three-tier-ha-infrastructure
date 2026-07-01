variable "project_name" {
  description = "Project name used as a prefix for all resource names"
  type        = string
  default     = "three-tier-ha"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet 1 (AZ-a)"
  type        = string
  default     = "10.0.0.0/20"
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet 2 (AZ-b)"
  type        = string
  default     = "10.0.16.0/20"
}

variable "private_app_subnet_1_cidr" {
  description = "CIDR for private app subnet 1 (AZ-a)"
  type        = string
  default     = "10.0.128.0/20"
}

variable "private_app_subnet_2_cidr" {
  description = "CIDR for private app subnet 2 (AZ-b)"
  type        = string
  default     = "10.0.144.0/20"
}

variable "private_db_subnet_1_cidr" {
  description = "CIDR for private DB subnet 1 (AZ-a)"
  type        = string
  default     = "10.0.160.0/20"
}

variable "private_db_subnet_2_cidr" {
  description = "CIDR for private DB subnet 2 (AZ-b)"
  type        = string
  default     = "10.0.176.0/20"
}
