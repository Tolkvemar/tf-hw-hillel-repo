# main-bucket.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-bk-shop-alexandr-2026"
  #lifecycle {
   #prevent_destroy = true
#   ignore_changes = [tags["LastScan"], password]
   #create_before_destroy = true
  #}

  tags = {
    Name      = "Terraform State Bucket"
    Project   = "tf-shop"
    ManagedBy = "terraform"
  }
}
 

