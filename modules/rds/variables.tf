variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
}

variable "private_db_subnet_1_id" {
  description = "ID of private DB subnet 1"
  type        = string
}

variable "private_db_subnet_2_id" {
  description = "ID of private DB subnet 2"
  type        = string
}

variable "db_sg_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}
