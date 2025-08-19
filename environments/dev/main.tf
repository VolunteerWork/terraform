terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  backend "s3" {
    bucket  = "volunteerwork-dev-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "volunteerwork-dev-terraform-lock"
  }
}

provider "aws" {
  region = var.region
}

##########################################
# Network
##########################################
module "network" {
  source = "../../modules/network"
  
  project_name = var.project_name
  env                     = var.env
  region                  = var.region
  availability_zones      = var.availability_zones
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_data_subnet_cidrs = var.private_data_subnet_cidrs
}

##########################################
# Security Groups Module
##########################################
module "security-groups" {
  source = "../../modules/security-groups"
  
  project_name = var.project_name
  env   = var.env
  vpc_id   = module.network.vpc_id
  
  db_public_access = true
  tags            = var.tags
}

##########################################
# IAM Module
##########################################
module "iam" {
  source = "../../modules/iam"
  
  project_name = var.project_name
  env   = var.env
  
  tags            = var.tags
}

module "ssm-parameters"{
  source = "../../modules/ssm-parameters"

  project_name = var.project_name
  env   = var.env

  docdb_username = var.docdb_username
  docdb_password = var.docdb_password
  jwt_secret_key = var.jwt_secret_key
  cloudinary_url = var.cloudinary_url
  cloudinary_api_key = var.cloudinary_api_key
  cloudinary_api_secret = var.cloudinary_api_secret
  cloudinary_name = var.cloudinary_name
  email_user = var.email_user
  email_pass = var.email_pass
}

module "database"{
  source = "../../modules/database"

  project_name = var.project_name
  env   = var.env

  docdb_username = var.docdb_username
  docdb_password = var.docdb_password
  docdb_sg_id = module.security-groups.docdb_sg_id
  private_data_subnet_ids = module.network.private_data_subnet_ids
  tags   = var.tags
}

##########################################
# Load Balancer Module
##########################################
module "loadbalancer" {
  source = "../../modules/loadbalancer"
  
  project_name = var.project_name
  env   = var.env
  vpc_id   = module.network.vpc_id
  
  lb_sg_id = module.security-groups.lb_sg_id
  public_subnet_ids = module.network.public_subnet_ids
  tags            = var.tags
}

module "ecs"{
  source = "../../modules/ecs"

  project_name = var.project_name
  env   = var.env

  private_app_subnet_ids = var.private_app_subnet_cidrs
  
  backend_service_sg_id = module.security-groups.backend_ecs_service_sg_id
  frontend_service_sg_id = module.security-groups.frontend_ecs_service_sg_id
  frontend_service_iam_arn = module.iam.ecs_task_execution_role_arn
  backend_service_iam_arn = module.iam.ecs_task_execution_role_arn
  frontend_target_group_arn = module.loadbalancer.frontend_target_group_arn
  backend_target_group_arn = module.loadbalancer.backend_target_group_arn
  
  db_username_arn = module.ssm-parameters.db_username_arn
  db_password_arn = module.ssm-parameters.db_password_arn
  jwt_secret_key_arn = module.ssm-parameters.jwt_secret_key_arn
  cloudinary_url_arn = module.ssm-parameters.cloudinary_url_arn
  cloudinary_api_key_arn = module.ssm-parameters.cloudinary_api_key_arn
  cloudinary_api_secret_arn = module.ssm-parameters.cloudinary_api_secret_arn
  cloudinary_name_arn = module.ssm-parameters.cloudinary_name_arn
  email_user_arn = module.ssm-parameters.email_user_arn
  email_pass_arn = module.ssm-parameters.email_user_arn

  documentdb_endpoint = module.database.documentdb_endpoint
  documentdb_port = module.database.documentdb_port

  tags   = var.tags
}

