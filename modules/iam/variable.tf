variable "env" {
  type = string
  default = "dev"
}

# Project name
variable "project_name" {
  type = string
}

variable "kms_myapp_secrets_arn" {
  description = "The ARN of the KMS key"
  type = string
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}