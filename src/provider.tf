
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.0"
    }
  }

  backend "s3" {
    bucket  = "chda-state-bucket"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
