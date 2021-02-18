# ##################
# # IMPORTANT NOTE #
# ##################

# ### In Linux Academy you are not allow to create DB with the user provided. For testing purposes you could deploy on your own
# ### AWS account and destroy after testing

# #############
# # AURORA DB #
# #############

# module "bitwarden_db" {
#   source  = "terraform-aws-modules/rds-aurora/aws"
#   version = "~> 3.0"

#   name          = "${local.name}-postgres"
#   username      = "bitwarden_user"
#   password      = "Test123456*!"
  
#   engine                          = "aurora-postgresql"
#   engine_version                  = "10.7"

#   vpc_id                          = data.aws_vpc.vpc_id.id
# #   subnets                         = ["subnet-05297f83cd13b1227", "subnet-087b4125e01a1ff68", "subnet-001ab79c3cc496f73"]
#   subnets                         = var.private_subnets

#   replica_count                   = 2
#   allowed_security_groups         = [aws_security_group.bw_db_sg.id]
#   allowed_cidr_blocks             = ["10.50.0.0/16"]
#   instance_type                   = var.db_instance
#   storage_encrypted               = true
#   apply_immediately               = true

#   db_parameter_group_name         = "default.aurora-postgresql10"
#   db_cluster_parameter_group_name = "default.aurora-postgresql10"

# #   enabled_cloudwatch_logs_exports = ["postgresql"]
#   tags                            = local.tags
#   }

# resource "aws_security_group" "bw_db_sg" {
#   name        = "${local.name}-db-sg"
#   description = "Allow Bitwarden DB traffic"
#   vpc_id      = data.aws_vpc.vpc_id.id

#   ingress {
#     description = "Bitwarden DB connection"
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["10.50.0.0/16"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }