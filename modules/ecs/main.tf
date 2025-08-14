######################################
# ECS CLUSTER
######################################
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.env}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-ecs-cluster"
      Environment = var.env
    },
    var.tags
  )
}

######################################
# ECS SERVICES
######################################
resource "aws_ecs_service" "backend_service" {
  name            = "${var.project_name}-${var.env}-backend-service"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend_task_definition.arn
  desired_count   = var.backend_desired_count
  iam_role        = var.backend_service_iam_arn

  load_balancer {
    target_group_arn = var.backend_target_group_arn
    container_name   = var.backend_container_definitions.name
    container_port   = var.backend_container_definitions.portMappings[0].containerPort
  }

  network_configuration {
    subnets          = var.private_app_subnet_ids
    security_groups  = [var.backend_service_sg_id]
    assign_public_ip = false
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-backend-service"
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_ecs_service" "frontend_service" {
  name            = "${var.project_name}-${var.env}-frontend-service"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend_task_definition.arn
  desired_count   = var.frontend_desired_count
  iam_role        = var.frontend_service_iam_arn

  load_balancer {
    target_group_arn = var.frontend_target_group_arn
    container_name   = var.frontend_container_definitions.name
    container_port   = var.frontend_container_definitions.portMappings[0].containerPort
  }

  network_configuration {
    subnets          = var.private_app_subnet_ids
    security_groups  = [var.frontend_service_sg_id]
    assign_public_ip = false
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-frontend-service"
      Environment = var.env
    },
    var.tags
  )
}

######################################
# ECS Task Definitions
######################################
resource "aws_ecs_task_definition" "backend_task_definition" {
  family                = "${var.project_name}"
  container_definitions = jsonencode(var.backend_container_definitions)

  lifecycle {
    ignore_changes = [container_definitions]
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-backend-task"
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_ecs_task_definition" "frontend_task_definition" {
  family                = "${var.project_name}"
  container_definitions = jsonencode(var.frontend_container_definitions)

  lifecycle {
    ignore_changes = [container_definitions]
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-frontend-task"
      Environment = var.env
    },
    var.tags
  )
}