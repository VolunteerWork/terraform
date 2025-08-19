output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "task_definition_ids" {
  description = "The ID list of task definitions"
  value       = [aws_ecs_task_definition.backend_task_definition.id, aws_ecs_task_definition.frontend_task_definition.id]
}

output "ecs_service_ids" {
  description = "The Id list of ECS services"
  value       = [aws_ecs_service.backend_service.id, aws_ecs_service.frontend_service.id]
}

