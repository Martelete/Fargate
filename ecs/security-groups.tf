resource "aws_security_group" "bw_sg" {
  name        = "${local.name}-security-group"
  description = "Allow Bitwarden traffic"
  vpc_id      = data.aws_vpc.vpc_id.id

  ingress {
    description = "HTTP port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}