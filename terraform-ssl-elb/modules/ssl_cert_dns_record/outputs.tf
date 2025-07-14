output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

output "cert_domain" {
  value = aws_acm_certificate.cert.domain_name
}
