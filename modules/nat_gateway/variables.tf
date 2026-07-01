variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
}

variable "public_subnet_1_id" {
  description = "ID of public subnet 1 (AZ-a) where NAT Gateway 1 will be placed"
  type        = string
}

variable "public_subnet_2_id" {
  description = "ID of public subnet 2 (AZ-b) where NAT Gateway 2 will be placed"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID - ensures IGW exists before NAT Gateway creation"
  type        = string
}
