output "certificate_id" {
    value = aws_acm_certificate.ssl_cert.*.id
}