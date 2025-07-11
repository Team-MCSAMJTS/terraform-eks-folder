output "certificate_arn" {
  value = aws_acm_certificate.this.arn
}

output "https_listener_arn" {
  value = aws_lb_listener.https.arn
}
