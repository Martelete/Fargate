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

data "aws_subnet_ids" "database" {
  vpc_id = data.aws_vpc.vpc_id.id
  filter {
    name   = "tag:Name"
    values = ["${var.env}-bitwarden-vpc-db*"]
  }
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