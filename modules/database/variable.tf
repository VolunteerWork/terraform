variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "private_data_subnet_ids" {
  description = "List of private data subnet IDs"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

variable "docdb_sg_id" {
  description = "Security group ID for DocumentDB"
  type        = string
}

variable "docdb_username" {
  description = "Username for DocumentDB"
  type        = string
  sensitive   = true
  default = "dbadmin"
}

variable "docdb_password" {
  description = "Password for DocumentDB"
  type        = string
  sensitive   = true
  default = "Kobiet.123"
}

variable "docdb_instance_class" {
  description = "Instance class for DocumentDB"
  type        = string
  default     = "db.t3.medium"
}

variable "docdb_instance_count" {
  description = "Number of DocumentDB instances"
  type        = number
  default     = 2
}

variable "docdb_deletion_protection" {
  description = "Whether to enable deletion protection for DocumentDB"
  type        = bool
  default     = false
}