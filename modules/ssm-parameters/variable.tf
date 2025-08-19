variable "env" {
  type = string
  default = "dev"
}

variable "project_name" {
  type = string
}

##########################################
# DocumentDB Secrets
##########################################
variable "docdb_username" {
  description = "Username for DocumentDB"
  type        = string
  sensitive   = true
}

variable "docdb_password" {
  description = "Password for DocumentDB"
  type        = string
  sensitive   = true
}

##########################################
# JWT Secrets
##########################################
variable "jwt_secret_key" {
  description = "Secret key for generating JWT tokens"
  type        = string
  sensitive   = true
}

##########################################
# Cloudinary Secrets
##########################################
variable "cloudinary_url" {
  description = "Cloudinary URL"
  type        = string
}

variable "cloudinary_api_key" {
  description = "Cloudinary API Key"
  type        = string
  sensitive   = true
}

variable "cloudinary_api_secret" {
  description = "Cloudinary API Secret"
  type        = string
  sensitive   = true
}

variable "cloudinary_name" {
  description = "Cloudinary Name"
  type        = string
}

##########################################
# Email Secrets
##########################################
variable "email_user" {
  description = "Email User"
  type        = string
}

variable "email_pass" {
  description = "Email Password"
  type        = string
}