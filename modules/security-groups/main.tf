##########################################
# Load Balancer Security Groups
##########################################
resource "aws_security_group" "lb_sg" {
  name        = "${var.project_name}-${var.env}-lb-sg"
  description = "Security group for load balancer"
  vpc_id      = var.vpc_id

  # Ingress rules
  ingress {
    description = "Allow HTTP"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-frontend-ecs-service-sg"
      Environment = var.env
    },
    var.tags
  )
}

##########################################
# ECS Security Groups
##########################################
resource "aws_security_group" "backend_ecs_service_sg" {
  name        = "${var.project_name}-${var.env}-backend-ecs-service-sg"
  description = "Security group for backend ECS service"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 0
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-backend-ecs-service-sg"
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_security_group" "frontend_ecs_service_sg" {
  name        = "${var.project_name}-${var.env}-frontend-ecs-service-sg"
  description = "Security group for frontend ECS service"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-frontend-ecs-service-sg"
      Environment = var.env
    },
    var.tags
  )
}

##########################################
# DocumentDB Security Groups
##########################################
resource "aws_security_group" "docdb_sg" {
  name        = "${var.project_name}-${var.env}-docdb-sg"
  description = "Security group for DocumentDB cluster"
  vpc_id      = var.vpc_id

  # DocumentDB
  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_ecs_service_sg.id]
    description     = "Allow DocumentDB access from EKS nodes"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-docdb-sg"
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_security_group_rule" "docdb_public" {
  count             = var.db_public_access ? 1 : 0
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.docdb_sg.id
  description       = "Allow public access to DocumentDB"
}

