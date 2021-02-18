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



# ######## Testing new functionality ########
# module "vpc" {
#   source                        = "terraform-aws-modules/vpc/aws"
#   version                       = "2.15.0"
  
#   name                          = local.name
#   cidr                          = var.cidr_block[local.env]
  
#   azs                           = slice(data.aws_availability_zones.available.names, 0, var.subnet_count[local.env])
#   public_subnets                = data.template_file.public_cidrsubnet[*].rendered
#   private_subnets               = var.private_subnets
#   database_subnets              = var.database_subnets
  
#   enable_nat_gateway            = true
#   enable_dns_hostnames          = true
#   tags                          = local.tags
# }
