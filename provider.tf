# Specify the provider and access details
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Name = "terraform"
      Project = "universal dashboard"
    }
  }
}