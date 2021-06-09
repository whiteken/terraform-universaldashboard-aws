# Lock in the specify the provider version
terraform {

  #version of the terraform executable
  required_version = "0.14.5"

  #version of the aws provider
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