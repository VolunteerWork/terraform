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
# ECS Task Definitions
######################################
resource "aws_ecs_task_definition" "backend_task_definition" {
  family                = "${var.project_name}-${var.env}-backend-family"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name = "backend"
      cpu = var.backend_container_config.cpu
      memory = var.backend_container_config.memory
      essential = true
      image = var.backend_container_config.image
      portMappings = [{
        containerPort = var.backend_container_config.containerPort
        hostPort = 80
      }],
      environment: [
        { name = "DB_HOST", value = var.documentdb_endpoint },
        { name = "DB_PORT", value = tostring(var.documentdb_port) },
        { name = "DB_NAME", value = "volunteerworkdb" }
      ]
      secrets = [
        { name = "DB_USER", valueFrom = var.db_username_arn },
        { name = "DB_PASS", valueFrom = var.db_password_arn },
        { name = "JWT_SECRET_KEY", valueFrom = var.jwt_secret_key_arn },
        { name = "CLOUDINARY_URL", valueFrom = var.cloudinary_url_arn },
        { name = "CLOUDINARY_API_KEY", valueFrom = var.cloudinary_api_key_arn },
        { name = "CLOUDINARY_API_SECRET", valueFrom = var.cloudinary_api_secret_arn },
        { name = "CLOUDINARY_NAME", valueFrom = var.cloudinary_name_arn },
        { name = "EMAIL_USER", valueFrom = var.email_user_arn },
        { name = "EMAIL_PASS", valueFrom = var.email_pass_arn }
      ]
    }
  ])

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
  family                = "${var.project_name}-${var.env}-frontend-family"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name = "frontend"
      cpu = var.frontend_container_config.cpu
      memory = var.frontend_container_config.memory
      essential = true
      image = var.frontend_container_config.image
      portMappings = [{
        containerPort = var.frontend_container_config.containerPort
        hostPort = 80
      }],
      environment: [
        { name = "NEXT_PUBLIC_API_BASE_URL", value = "/api" }
      ]
    }
  ])

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
    container_name   =  var.backend_container_config.name
    container_port   = var.backend_container_config.containerPort
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
    container_name   = var.frontend_container_config.name
    container_port   = var.frontend_container_config.containerPort
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