# locals.tf

locals {
  name_prefix = "${var.project}-${var.env}"
  
  common_tags = {
    Project   = var.project
    Env       = var.env
    ManagedBy = "terraform"
  }
  subnets = {
    for k, v in var.subnets : k => {
      cidr = cidrsubnet(var.vpc_cidr, 8, v.netnum)
      az = v.az
     }
  } 
  env = terraform.workspace
  instance_type = {
    dev = "t3.micro"
    prod = "t3.small"
  }[terraform.workspace]
}

