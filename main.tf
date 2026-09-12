# main.tf
terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
/*  backend "s3" {
    bucket       = "tf-state-alexandr-2026"
    key          = "shop/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }*/

   cloud {
     organization = "SCP-049"
     workspaces {
       tags = ["shop"]
     }
   } 
}
provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "assets" {
  bucket = "tf-shop-assets-alexandr-2026"
  tags = {
    Owner     = "Alexxandr"
    Name      = "tf-shop assets"
    ManagedBy = "terraform"
  }
}
module "network" {
  source = "./modules/network"
  project  = var.project
  region   = var.region
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
  tags     = local.common_tags
}
