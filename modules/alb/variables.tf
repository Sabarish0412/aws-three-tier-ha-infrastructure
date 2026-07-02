variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
}

variable "alb_web_sg_id" {
  description = "Security group ID for the public web ALB"
  type        = string
}

variable "alb_app_sg_id" {
  description = "Security group ID for the internal app ALB"
  type        = string
}

variable "public_subnet_1_id" {
  description = "ID of public subnet 1 for the web ALB"
  type        = string
}

variable "public_subnet_2_id" {
  description = "ID of public subnet 2 for the web ALB"
  type        = string
}

variable "private_app_subnet_1_id" {
  description = "ID of private app subnet 1 for the internal ALB"
  type        = string
}

variable "private_app_subnet_2_id" {
  description = "ID of private app subnet 2 for the internal ALB"
  type        = string
}
