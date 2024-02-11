terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.30.0"
    }
  }
  backend "s3" {
    bucket = "backend-bk"
    key    = "backend-bk/web.tfstate"
    region = "us-east-1"
    
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}