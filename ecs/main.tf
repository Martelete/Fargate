###############
# ECS CLUSTER #
###############

resource "aws_ecs_cluster" "ecs" {
  name    = "${local.name}-${var.env}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags    = local.tags
}

resource "aws_ecs_task_definition" "bitwarden_td" {
  family                   = local.name
  execution_role_arn       = aws_iam_role.execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = 2048
  cpu                      = 1024

  container_definitions = templatefile("${path.module}/templates/bitwarden_task.json", {
    db_username         = "${local.name}-mysql"
    db_password         = local.db_password
  })

  volume {
    name      = "data"
  }

  tags = local.tags
}

resource "aws_ecs_service" "bitwarden_service" {
  name            = "${local.name}-service"
  cluster         = "${local.name}-${var.env}"
  task_definition = aws_ecs_task_definition.bitwarden_td.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  depends_on = [aws_ecs_cluster.ecs, aws_iam_role_policy_attachment.execution_role_attachment, aws_alb.bitwarden_alb]

  load_balancer {
    target_group_arn = aws_alb_target_group.bitwarden_tg.arn
    container_name   = "bitwarden"
    container_port   = 80
  }

  network_configuration {
    subnets             = data.aws_subnet_ids.private.ids
    security_groups     = [aws_security_group.bw_sg.id]
    assign_public_ip    = true
  }
}