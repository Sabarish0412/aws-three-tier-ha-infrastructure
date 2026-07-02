output "rds_endpoint" {
  description = "Connection endpoint for the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "rds_instance_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.main.id
}
