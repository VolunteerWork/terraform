variable "env" {
  type = string
  default = "dev"
}

# Project name
variable "project_name" {
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}


variable "lb_sg_id" {
  description = "Id of security group of load balancer"
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type = list(string)
}

variable "backend_port" {
  description = "Port of backend app"
  type = number
  default = 8080
}

variable "frontend_port" {
  description = "Port of frontend app"
  type = number
  default = 3000
}

variable "frontend_healthcheck" {
  type = object({
    path                = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
    matcher             = string
  })
  default = {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

variable "backend_healthcheck" {
  type = object({
    path                = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
    matcher             = string
  })
  default = {
    path                = "/api/healthcheck"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}


# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}