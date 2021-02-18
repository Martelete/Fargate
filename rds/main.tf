###################
# MYSQL AURORA DB #
###################

##### In case parameter group does not exist #####
# resource "aws_db_parameter_group" "mysql_parameter_group" {
#   name        = "aurora-mysql5.7"
#   family      = "aurora-mysql5.7"
#   description = "Default Parameter group for MySQL 5.7"
# }

module "bitwarden_db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"

  name                            = "${local.name}-mysql"
  username                        = "${local.name}-mysql-db"
  password                        = local.db_password
  
  engine                          = "aurora-mysql"
  engine_version                  = "5.7.12"

  vpc_id                          = data.aws_vpc.vpc_id.id
  subnets                         = [data.aws_subnet_ids.database.ids]

  replica_count                   = 1
  allowed_security_groups         = [aws_security_group.bw_db_sg.id]
  allowed_cidr_blocks             = ["10.50.0.0/16"]
  instance_type                   = var.db_instance
  storage_encrypted               = true
  apply_immediately               = true

  db_parameter_group_name         = "default.aurora-mysql5.7"

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  tags                            = local.tags
  }

resource "aws_security_group" "bw_db_sg" {
  name        = "${local.name}-db-sg"
  description = "Allow Bitwarden DB traffic"
  vpc_id      = data.aws_vpc.vpc_id.id

  ingress {
    description = "Bitwarden DB connection"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.50.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}