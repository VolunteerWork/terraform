variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "env" {
  description = "Deployment Environment"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "db_public_access" {
  description = "Allow public access to db for testing purposes"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}