variable "env" {
  type = string
  default = "dev"
}

# Project name
variable "project_name" {
  type = string
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}