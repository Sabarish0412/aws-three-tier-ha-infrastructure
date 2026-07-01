output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_a_id" {
  description = "ID of the private route table for AZ-a"
  value       = aws_route_table.private_a.id
}

output "private_route_table_b_id" {
  description = "ID of the private route table for AZ-b"
  value       = aws_route_table.private_b.id
}

