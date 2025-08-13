######################################
# ECS CLUSTER
######################################
resource "aws_ecs_cluster" "ecs_cluster" {
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
# ECS SERVICE
######################################
resource "aws_ecs_service" "backend_service" {
  count           = length(var.applications)
  name            = "${var.project_name}-${var.env}-${applications[count.index]}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 2
  iam_role        = aws_iam_role.ecs_service_role.arn
  depends_on      = [aws_iam_role_policy.foo]

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = container_definitions[count.index].name
    container_port   = container_definitions[count.index].portMappings[0].containerPort
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