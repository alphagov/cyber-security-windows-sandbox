# Setup the AWS provider | provider.tf
terraform {
  required_version = ">= 0.12"
}
provider "aws" {
  version = "~> 3.19"
  region  = var.aws_region
}