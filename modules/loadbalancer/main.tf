######################################
# Load Balancer
######################################
resource "aws_lb" "main" {
  name               = "${var.project_name}-${var.env}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_ids

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-load-balancer"
      Environment = var.env
    },
    var.tags
  )
}

######################################
# Target Groups
######################################
resource "aws_lb_target_group" "backend_tg" {
  name     = "${var.project_name}-${var.env}-backend-tg"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.backend_healthcheck.path
    interval            = var.backend_healthcheck.interval
    timeout             = var.backend_healthcheck.timeout
    healthy_threshold   = var.backend_healthcheck.healthy_threshold
    unhealthy_threshold = var.backend_healthcheck.unhealthy_threshold
    matcher             = var.backend_healthcheck.matcher
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-backend-tg"
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "${var.project_name}-${var.env}-frontend-tg"
  port     = var.frontend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.frontend_healthcheck.path
    interval            = var.frontend_healthcheck.interval
    timeout             = var.frontend_healthcheck.timeout
    healthy_threshold   = var.frontend_healthcheck.healthy_threshold
    unhealthy_threshold = var.frontend_healthcheck.unhealthy_threshold
    matcher             = var.frontend_healthcheck.matcher
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-frontend-tg"
      Environment = var.env
    },
    var.tags
  )
}

######################################
# Listeners And Listener Rules
######################################
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-app-listener"
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.app_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-backend-rule"
      Environment = var.env
    },
    var.tags
  )
}