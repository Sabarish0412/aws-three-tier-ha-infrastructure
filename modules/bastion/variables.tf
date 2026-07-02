variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion host (Amazon Linux 2023)"
  type        = string
}

variable "public_subnet_1_id" {
  description = "ID of public subnet 1 where bastion will be placed"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID for the bastion host"
  type        = string
}

variable "bastion_public_key" {
  description = "Public key material for the bastion SSH key pair"
  type        = string
}
