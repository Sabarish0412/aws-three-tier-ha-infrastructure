output "alb_web_sg_id" {
  description = "ID of the public web ALB security group"
  value       = aws_security_group.alb_web_sg.id
}

output "web_sg_id" {
  description = "ID of the web tier EC2 security group"
  value       = aws_security_group.web_sg.id
}

output "alb_app_sg_id" {
  description = "ID of the internal app ALB security group"
  value       = aws_security_group.alb_app_sg.id
}

output "app_sg_id" {
  description = "ID of the app tier EC2 security group"
  value       = aws_security_group.app_sg.id
}

output "db_sg_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.db_sg.id
}

output "bastion_sg_id" {
  description = "ID of the bastion host security group"
  value       = aws_security_group.bastion_sg.id
}
