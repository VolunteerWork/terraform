project_name              = "volunteerwork"
region                    = "us-east-1"
env                       = "prod"
availability_zones        = ["us-east-1a", "us-east-1b"]
vpc_cidr                  = "10.0.0.0/16"
public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
private_app_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
private_data_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]

kms_arn                   = "arn:aws:kms:us-east-1:770825631895:key/0d16a093-0f0d-43ac-8b01-8b0d89c95da4"
db_url_arn                = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/db/url"
jwt_secret_key_arn        = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/jwt/secret_key"
cloudinary_url_arn        = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/cloudinary/url"
cloudinary_api_key_arn    = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/cloudinary/api_key"
cloudinary_api_secret_arn = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/cloudinary/api_secret"
cloudinary_name_arn       = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/cloudinary/name"
email_user_arn            = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/email/user"
email_pass_arn            = "arn:aws:ssm:us-east-1:770825631895:parameter/volunteerwork/prod/email/password"