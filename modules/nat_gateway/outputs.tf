output "nat_gw_1_id" {
  description = "ID of NAT Gateway 1 (AZ-a)"
  value       = aws_nat_gateway.nat_1.id
}

output "nat_gw_2_id" {
  description = "ID of NAT Gateway 2 (AZ-b)"
  value       = aws_nat_gateway.nat_2.id
}
