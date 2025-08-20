variable "env" {
  type = string
  default = "dev"
}

# Project name
variable "project_name" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

# Desired count of backend app
variable "backend_desired_count" {
  type = number
  default = 1
}

# Desired count of frontend app
variable "frontend_desired_count" {
  type = number
  default = 1
}

variable "private_app_subnet_ids" {
  description = "List of private application subnet IDs"
  type = list(string)
}

variable "documentdb_endpoint" {
  description = "DocumentDB cluster endpoint"
  type = string
}

variable "documentdb_port" {
  description = "DocumentDB port"
  type = number
  default = 27017
}

variable "db_username_arn" {
  description = "The ARN of the SSM Parameter DB username"
  type = string
}

variable"db_password_arn" {
  description = "The ARN of the SSM Parameter DB password"
  type = string
}

variable "jwt_secret_key_arn" {
  description = "The ARN of the SSM Parameter Cloudinary URL"
  type = string
}

variable "cloudinary_url_arn" {
  description = "The ARN of the SSM Parameter Cloudinary URL"
  type = string
}

variable "cloudinary_api_key_arn" {
  description = "The ARN of the SSM Parameter Cloudinary API Key"
  type = string
}

variable "cloudinary_api_secret_arn" {
  description = "The ARN of the SSM Parameter Cloudinary API Secret"
  type = string
}

variable "cloudinary_name_arn" {
  description = "The ARN of the SSM Parameter Cloudinary Name"
  type = string
}

variable "email_user_arn" {
  description = "The ARN of the SSM Parameter Email User"
  type = string
}

variable "email_pass_arn" {
  description = "The ARN of the SSM Parameter Email Pass"
  type = string
}

variable "backend_service_sg_id" {
  description = "Id of security group of backend service"
  type = string
}

variable "frontend_service_sg_id" {
  description = "Id of security group of frontend service"
  type = string
}

variable "ecs_task_execution_role_arn" {
  description = "Arn string of ECS Task Execution role"
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

variable "backend_container_config" {
    type = object({
        name = string
        image        = string
        cpu          = number
        memory       = number
        containerPort = number
    })
    default = {
      name = "backend"
      cpu = 512
      memory = 1024
      image = "hungtran679/volunteerwork-backend:latest"
      containerPort = 8080
    }
}

variable "frontend_container_config" {
    type = object({
        name = string
        image        = string
        cpu          = number
        memory       = number
        containerPort = number
    })
    default = {
      name = "frontend"
      cpu = 512
      memory = 1024
      image = "hungtran679/volunteerwork-frontend:latest"
      containerPort = 3000
    }
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}