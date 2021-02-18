locals {
  name = "bitwarden"
  db_password = jsondecode("${data.aws_secretsmanager_secret_version.db_password.secret_string}")["db_password"]

  tags = {
    Team          = local.name
    Environment   = var.env
    Product       = local.name
    OS            = "linux"
  }
}