output "web_alb_arn" {
  description = "ARN of the public web ALB"
  value       = aws_lb.web.arn
}

output "web_alb_dns" {
  description = "DNS name of the public web ALB"
  value       = aws_lb.web.dns_name
}

output "web_target_group_arn" {
  description = "ARN of the web tier target group"
  value       = aws_lb_target_group.web.arn
}

output "app_alb_arn" {
  description = "ARN of the internal app ALB"
  value       = aws_lb.app.arn
}

output "app_alb_dns" {
  description = "DNS name of the internal app ALB"
  value       = aws_lb.app.dns_name
}

output "app_target_group_arn" {
  description = "ARN of the app tier target group"
  value       = aws_lb_target_group.app.arn
}
