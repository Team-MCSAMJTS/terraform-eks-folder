output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

output "record_fqdn" {
  value = aws_route53_record.a_record.fqdn
}
