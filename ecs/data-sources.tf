data "aws_vpc" "vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["${var.env}-bitwarden-vpc"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.vpc_id.id
  filter {
    name   = "tag:Name"
    values = ["${var.env}-bitwarden-vpc-private*"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.vpc_id.id
  filter {
    name   = "tag:Name"
    values = ["${var.env}-bitwarden-vpc-public*"]
  }
}

data "aws_subnet_ids" "database" {
  vpc_id = data.aws_vpc.vpc_id.id
  filter {
    name   = "tag:Name"
    values = ["${var.env}-bitwarden-vpc-db*"]
  }
}

data "aws_acm_certificate" "ssl_bitwarden" {
  domain      = var.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "bw_zone" {
  name         = var.dns_name
  private_zone = false
}