resource "aws_route53_record" "bw_url" {
  zone_id = data.aws_route53_zone.bw_zone.zone_id
  type    = "A"
  name    = "${local.name}.${var.dns_name}"

  alias {
    name                   = aws_alb.bitwarden_alb.dns_name
    zone_id                = aws_alb.bitwarden_alb.zone_id
    evaluate_target_health = false
  }
}