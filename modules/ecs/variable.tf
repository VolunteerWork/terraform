variable "env" {
  type = string
  default = "dev"
}

# Project name
variable "project_name" {
  type = string
}

# Desired count of backend app
variable "backend_desired_count" {
  type = number
  default = 2
}

# Desired count of frontend app
variable "frontend_desired_count" {
  type = number
  default = 2
}

variable "private_app_subnet_ids" {
  description = "List of private application subnet IDs"
  type = list(string)
}

variable "backend_service_sg_id" {
  description = "Id of security group of backend service"
  type = string
}

variable "frontend_service_sg_id" {
  description = "Id of security group of frontend service"
  type = string
}

variable "frontend_service_iam_arn" {
  description = "Arn string of backend service IAM role"
  type = string
}

variable "backend_service_iam_arn" {
  description = "Arn string of backend service IAM role"
  type = string
}

variable "backend_target_group_arn" {
  description = "ARN of the backend target group"
  type       = string
}

variable "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  type       = string
}

variable "backend_container_definitions" {
    type = object({
        name         = string
        image        = string
        cpu          = number
        memory       = number
        essential    = bool
        portMappings = list(object({
            containerPort = number
            hostPort      = number
        }))
    })
    default = {
      name = "backend"
      cpu = 10
      memory = 512
      essential = true
      image = "hungtran679/volunteerwork-backend:latest"
      portMappings = [{
        containerPort = 8080
        hostPort = 80
      }]
    }
}

variable "frontend_container_definitions" {
    type = object({
        name         = string
        image        = string
        cpu          = number
        memory       = number
        essential    = bool
        portMappings = list(object({
            containerPort = number
            hostPort      = number
        }))
    })
    default = {
      name = "frontend"
      cpu = 10
      memory = 512
      essential = true
      image = "hungtran679/volunteerwork-frontend:latest"
      portMappings = [{
        containerPort = 3000
        hostPort = 80
      }]
    }
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}