output "kms_myapp_secrets_arn" {
  description = "The ARN of the KMS key"
  value       = aws_kms_key.myapp_secrets.arn
}

output "db_username_arn" {
  description = "The ARN of the DB username secret"
  value       = aws_ssm_parameter.db_username.arn
}

output "db_password_arn" {
  description = "The ARN of the DB password"
  value       = aws_ssm_parameter.db_password.arn
}

output "jwt_secret_key_arn" {
  description = "The ARN of the Cloudinary URL"
  value       = aws_ssm_parameter.cloudinary_url.arn
}

output "cloudinary_url_arn" {
  description = "The ARN of the Cloudinary URL"
  value       = aws_ssm_parameter.cloudinary_url.arn
}

output "cloudinary_api_key_arn" {
  description = "The ARN of the Cloudinary API Key"
  value       = aws_ssm_parameter.cloudinary_api_key.arn
}

output "cloudinary_api_secret_arn" {
  description = "The ARN of the Cloudinary API Secret"
  value       = aws_ssm_parameter.cloudinary_api_secret.arn
}

output "cloudinary_name_arn" {
  description = "The ARN of the Cloudinary Name"
  value       = aws_ssm_parameter.cloudinary_name.arn
}

output "email_user_arn" {
  description = "The ARN of the Email User"
  value       = aws_ssm_parameter.cloudinary_name.arn
}

output "email_pass_arn" {
  description = "The ARN of the Email Pass"
  value       = aws_ssm_parameter.email_pass.arn
}
