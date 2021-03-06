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

data "aws_route53_zone" "bw_zone" {
  name         = var.dns_name
  private_zone = false
}

###################
# SSL CERTIFICATE #
###################

data "aws_acm_certificate" "ssl_bitwarden" {
  domain      = var.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}

###################
# Secrets Manager #
###################

data "aws_secretsmanager_secret_version" "mysql_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

data "aws_secretsmanager_secret" "db_password" {
  name = "bitwarden/mysql_password"
}
