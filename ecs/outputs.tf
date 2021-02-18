output "alb_hostname" {
    value = aws_alb.bitwarden_alb.dns_name
}

output "url" {
    value = aws_route53_record.bw_url.*.fqdn
}