##################
# IMPORTANT NOTE #
##################

### The certificate is already created in our AWS account once pushed to Prod. We are going to use *.zaizi.com for Prod.
### We are just testing the ssl_certificate on Linux Academy account hence the creation of this section

resource "aws_acm_certificate" "ssl_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

data "aws_route53_zone" "primary" {
  name          = var.zone_name
  private_zone  = false
}

resource "aws_route53_record" "bw_record" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "ssl_bitwarden" {
  certificate_arn         = aws_acm_certificate.ssl_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.bw_record : record.fqdn]
}