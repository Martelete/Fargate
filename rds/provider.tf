##################
# Setup provider #
##################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

#####################
# Setup the backend #
#####################
terraform {
  required_version = ">= 0.13" 
  backend "s3" {
    bucket = "<your_bucket_name>"
    region = var.region 
    key = "terraform/bitwarden/RDS/state.tf"
  }
  required_version = ">= 0.13"
} 