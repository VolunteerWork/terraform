variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "volunteerwork"
}

variable "region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Deployment Environment (dev, prod,straging)"
  type        = string
  default     = "dev"
}

# Availability Zones
variable "availability_zones" {
  type = list(string)
}

# VPC CIDR
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# Public subnet CIDRs
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Private subnet CIDRs for applications
variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Private subnet CIDRs for data
variable "private_data_subnet_cidrs" {
  description = "CIDR blocks for private data subnets"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

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

variable "jwt_secret_key" {
  description = "Secret key for generating JWT tokens"
  type        = string
  sensitive   = true
}

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

variable "email_user" {
  description = "Email User"
  type        = string
}

variable "email_pass" {
  description = "Email Password"
  type        = string
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}