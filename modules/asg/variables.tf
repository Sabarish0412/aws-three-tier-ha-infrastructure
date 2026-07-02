variable "ami_id" {
  description = "AMI ID for EC2 instances (Amazon Linux 2023)"
  type        = string
}
variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
}

variable "web_sg_id" {
  description = "Security group ID for web tier EC2 instances"
  type        = string
}

variable "app_sg_id" {
  description = "Security group ID for app tier EC2 instances"
  type        = string
}

variable "public_subnet_1_id" {
  description = "ID of public subnet 1 for web tier ASG"
  type        = string
}

variable "public_subnet_2_id" {
  description = "ID of public subnet 2 for web tier ASG"
  type        = string
}

variable "private_app_subnet_1_id" {
  description = "ID of private app subnet 1 for app tier ASG"
  type        = string
}

variable "private_app_subnet_2_id" {
  description = "ID of private app subnet 2 for app tier ASG"
  type        = string
}

variable "web_target_group_arn" {
  description = "ARN of the web tier target group"
  type        = string
}

variable "app_target_group_arn" {
  description = "ARN of the app tier target group"
  type        = string
}
