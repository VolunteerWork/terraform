##########################################
# ECS Task Execution Role
##########################################
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-${var.env}-ecs-task-execution-role"

  # TRUST POLICY
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

##########################################
# Attach default ECS Task Execution policy
##########################################
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

##########################################
# Inline policy for SSM & KMS
##########################################
resource "aws_iam_role_policy" "ecs_task_ssm_policy" {
  name = "${var.project_name}-${var.env}-ecs-task-ssm-policy"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt"
        ],
        Resource = var.kms_myapp_secrets_arn
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup"
        ],
        Resource = "*"
      },
    ]
  })
}
