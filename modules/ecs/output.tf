output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "ecs_service_ids" {
  description = "The Id list of ECS services"
  value       = [for ecs_service in aws_ecs_service.ecs_services : ecs_service.id]
}

output "task_definition_ids" {
  description = "The ID list of task definitions"
  value       = [for td in aws_ecs_task_definition.task_definitions : td.id]
}

