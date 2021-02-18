resource "aws_cloudwatch_log_group" "bw_ecs_log" {
  name              = "/ecs/fargate-task-definition/bitwarden"
  retention_in_days = 7

  tags = local.tags
}

resource "aws_cloudwatch_log_stream" "bw_log_stream" {
  name           = "Bitwarden-log-stream"
  log_group_name = aws_cloudwatch_log_group.bw_ecs_log.name
}