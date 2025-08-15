terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
   backend "s3" {
  bucket         = "nt548-terraform-state-dev"
  key            = "terraform.tfstate"
  region         = "ap-southeast-1"
  dynamodb_table = "nt548-terraform-lock-dev"
  }
}

provider "aws" {
  region = var.region
}