######################################
# ECS CLUSTER
######################################
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.env}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.project_name}-${var.env}-ecs-cluster"
  }
}

######################################
# ECS SERVICES
######################################
resource "aws_ecs_service" "backend_service" {
  count           = length(var.applications)
  name            = "${var.project_name}-${var.env}-backend-service"
  launch_type = "FARGATE"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend_task_definition.arn
  desired_count   = var.desired_count
  iam_role        = aws_iam_role.backend_ecs_service_role.arn
  depends_on      = [aws_iam_role_policy.foo]

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = var.container_definitions[count.index].name
    container_port   = var.container_definitions[count.index].portMappings[0].containerPort
  }
  
  network_configuration {
    subnets         = module.network.private_app_subnet_ids
    security_groups = [var.ecs_service_backend.id]
    assign_public_ip = false
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

######################################
# ECS Task definition
######################################
resource "aws_ecs_task_definition" "task_definitions" {
  count  = length(var.applications)
  family = "${var.project_name}"
  container_definitions = jsonencode(var.container_definitions)
  

  lifecycle {
    ignore_changes = [container_definitions]
  }
}