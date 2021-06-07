# Lock in the specify the provider version
terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
}

# Set details for provider with local name
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Name    = "terraform"
      Project = "universal dashboard"
    }
  }
}