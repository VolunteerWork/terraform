
output "load_balancer_arn" {
  description = "ARN of the main load balancer"
  value       = aws_lb.main.arn
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = aws_lb_target_group.backend_tg.arn
}

output "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  value       = aws_lb_target_group.frontend_tg.arn
}

output "app_listener_arn" {
  description = "ARN of the application load balancer listener"
  value       = aws_lb_listener.app_listener.arn
}