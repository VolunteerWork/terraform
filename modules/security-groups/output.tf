output "lb_sg_id" {
  description = "Load Balancer SG ID"
  value       = aws_security_group.lb_sg.id
}

output "backend_ecs_service_sg_id" {
  description = "Backend ECS Service SG ID"
  value       = aws_security_group.backend_ecs_service_sg.id
}

output "frontend_ecs_service_sg_id" {
  description = "Frontend ECS Service SG ID"
  value       = aws_security_group.frontend_ecs_service_sg.id
}

output "docdb_sg_id" {
  description = "DocumentDB SG ID"
  value       = aws_security_group.docdb_sg.id
}
