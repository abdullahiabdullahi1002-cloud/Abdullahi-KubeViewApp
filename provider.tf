terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.14.0" # Added version constraint to prevent breaking changes
    }
  }
}

provider "aws" {
    region = var.aws_region
}