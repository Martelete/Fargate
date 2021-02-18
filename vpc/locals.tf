locals {
  team  = "bitwarden"
  name  = "${local.env}-${local.team}-vpc"
  env   = "prod"

  ######## Testing new functionality ########
  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets  = ["${var.cidr_base}10.0/24", "${var.cidr_base}20.0/24", "${var.cidr_base}30.0/24"]
  public_subnets   = ["${var.cidr_base}40.0/24", "${var.cidr_base}50.0/24", "${var.cidr_base}60.0/24"]
  database_subnets = ["${var.cidr_base}70.0/24", "${var.cidr_base}80.0/24", "${var.cidr_base}90.0/24"]

  tags = {
    Team          = local.team
    Environment   = local.env
    Product       = local.team
    OS            = "linux"
  }
}