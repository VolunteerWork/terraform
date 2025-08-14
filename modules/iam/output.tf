output "ecs_task_execution_role_arn"{
    description = "Arn of ECS task execution role"
    value = aws_iam_role.ecs_task_execution_role.arn
}