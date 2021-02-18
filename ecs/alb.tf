# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE AN APPLICATION LOAD BALANCER (ALB)
# This creates an ALB, the necessary security groups, and sets up the desired ALB Listeners.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

resource "aws_alb" "bitwarden_alb" {
  name                = local.name
  internal            = false                              
  load_balancer_type  = "application"
  security_groups     = [aws_security_group.bw_sg.id]      
  subnets             = data.aws_subnet_ids.public.ids     
  tags                = local.tags
}

resource "aws_alb_target_group" "bitwarden_tg" {
  name        = "${local.name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc_id.id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    interval            = 10
    timeout             = 5
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  depends_on = [ aws_alb.bitwarden_alb ]

  tags = merge(local.tags,
    {
      Name = "${local.name}-sg"
    }
  )
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.bitwarden_alb.arn
  port              = 80
  protocol          = "HTTP"


  ##### FORWARD TO TG #####
  # default_action {
  #   type             = "forward"
  #   target_group_arn = aws_alb_target_group.bitwarden_tg.arn
  # }
  
  #### REDIRECT TO HTTPS #####
  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

##### LISTENER HTTPS #####

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.bitwarden_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = data.aws_acm_certificate.ssl_bitwarden.arn

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.bitwarden_tg.arn
    
  }
}