locals {
  name = "bitwarden"
  # db_username = jsondecode("${data.aws_secretsmanager_secret_version.db_passwd.secret_string}")["db_username"] 
  # db_password = jsondecode("${data.aws_secretsmanager_secret_version.db_passwd.secret_string}")["db_password"]
  test_user = "bw_test" 

  tags = {
    Team          = local.name
    Environment   = var.env
    Product       = local.name
    OS            = "linux"
  }
}