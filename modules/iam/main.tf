##########################################
# IAM Policy for ECS Task Definition
##########################################
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-${var.env}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-ecs-task-execution-role"
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
