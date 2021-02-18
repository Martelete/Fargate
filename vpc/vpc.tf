module "vpc" {
  source                        = "terraform-aws-modules/vpc/aws"
  # version                       = "=v2.18"
  
  name                          = local.name
  cidr                          = "${var.cidr_base}0.0/16"
  
  azs                           = local.azs
  private_subnets               = local.private_subnets
  public_subnets                = local.public_subnets
  database_subnets              = local.database_subnets
  
  enable_nat_gateway            = true
  enable_dns_hostnames          = true
  tags                          = local.tags
}