# data "aws_availability_zones" "available" {}

# data "template_file" "public_cidrsubnet" {
#   count = var.subnet_count[local.env]

#   template = "$${cidrsubnet(vpc_cidr,8,current_count)}"

#   vars = {
#     vpc_cidr      = var.cidr_block[local.env]
#     current_count = count.index
#   }
# }