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
  # backend          "s3"             {}
  required_version = ">= 0.13"
}

####################
# Backend for Prod #
####################

#### For Prod ideally we need to create a S3 bucket to store our state files in 
terraform {
  backend "s3" {
    bucket = "henriquehenriquehenrique1986"
    region = "us-east-1" 
    key = "terraform/bitwarden/VPC/state.tf"
  }
  required_version = ">= 0.13"
}