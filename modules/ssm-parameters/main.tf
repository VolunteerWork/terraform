##########################################
# AWS KMS KEY
##########################################
resource "aws_kms_key" "myapp_secrets" {
  description             = "KMS key for encrypting SSM Parameter secrets"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

##########################################
# SSM Parameter Secrets
##########################################
resource "aws_ssm_parameter" "db_username" {
  name        = "/${var.project_name}/${var.env}/db/username"
  type        = "SecureString"
  value       = var.docdb_username
  description = "DocumentDB Username"
  key_id      = aws_kms_key.myapp_secrets.arn
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.project_name}/${var.env}/db/password"
  type        = "SecureString"
  value       = var.docdb_password
  description = "DocumentDB Password"
  key_id      = aws_kms_key.myapp_secrets.arn
}

resource "aws_ssm_parameter" "jwt_secret_key" {
  name        = "/${var.project_name}/${var.env}/jwt/secret_key"
  type        = "SecureString"
  value       = var.jwt_secret_key
  description = "JWT Secret Key"
  key_id      = aws_kms_key.myapp_secrets.arn
}

resource "aws_ssm_parameter" "cloudinary_url" {
  name        = "/${var.project_name}/${var.env}/cloudinary/url"
  type        = "String"
  value       = var.cloudinary_url
  description = "Cloudinary URL"
}

resource "aws_ssm_parameter" "cloudinary_api_key" {
  name        = "/${var.project_name}/${var.env}/cloudinary/api_key"
  type        = "SecureString" # safer than String
  value       = var.cloudinary_api_key
  description = "Cloudinary API Key"
  key_id      = aws_kms_key.myapp_secrets.arn
}

resource "aws_ssm_parameter" "cloudinary_api_secret" {
  name        = "/${var.project_name}/${var.env}/cloudinary/api_secret"
  type        = "SecureString"
  value       = var.cloudinary_api_secret
  description = "Cloudinary API Secret"
  key_id      = aws_kms_key.myapp_secrets.arn
}

resource "aws_ssm_parameter" "cloudinary_name" {
  name        = "/${var.project_name}/${var.env}/cloudinary/name"
  type        = "String"
  value       = var.cloudinary_name
  description = "Cloudinary Account Name"
}

resource "aws_ssm_parameter" "email_user" {
  name        = "/${var.project_name}/${var.env}/email/user"
  type        = "SecureString"
  value       = var.email_user
  description = "Email User (login username)"
  key_id      = aws_kms_key.myapp_secrets.arn
}

resource "aws_ssm_parameter" "email_pass" {
  name        = "/${var.project_name}/${var.env}/email/password"
  type        = "SecureString"
  value       = var.email_pass
  description = "Email Password"
  key_id      = aws_kms_key.myapp_secrets.arn
}