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

variable "availability_zones" {
  type = list(string)
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_data_subnet_cidrs" {
  description = "CIDR blocks for private data subnets"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "kms_arn" {
  description = "The ARN of the KMS key"
  type        = string
}

variable "db_url_arn" {
  description = "The ARN of the DB username PS"
  type        = string
}

variable "jwt_secret_key_arn" {
  description = "The ARN of the JWT Secret Key PS"
  type        = string
}

variable "cloudinary_url_arn" {
  description = "The ARN of the Cloudinary URL PS"
  type        = string
}

variable "cloudinary_api_key_arn" {
  description = "The ARN of the Cloudinary API Key PS"
  type        = string
}

variable "cloudinary_api_secret_arn" {
  description = "The ARN of the Cloudinary API Secret PS"
  type        = string
}

variable "cloudinary_name_arn" {
  description = "The ARN of the Cloudinary Name PS"
  type        = string
}

variable "email_user_arn" {
  description = "The ARN of the Email User PS"
  type        = string
}

variable "email_pass_arn" {
  description = "The ARN of the Email Pass PS"
  type        = string
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}