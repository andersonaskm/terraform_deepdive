#####################################################
# Providers
#####################################################

provider "aws" {
  profile = "uninter"
  region  = var.region
}

#####################################################
# Data
#####################################################
data "aws_availability_zones" "available" {}

#####################################################
# Resources
#####################################################

# NETWORKING #
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "globo-primary"

  cidr            = var.cidr_block
  azs             = slice(data.aws_availability_zones.available.names, 0, var.subnet_count)
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = false

  create_database_subnet_group = false

  tags = {
    Environment = "Production"
    Team        = "SRE"
  }
}
