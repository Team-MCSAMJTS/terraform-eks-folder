resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  zone_id = var.hosted_zone_id
  records = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.validation.fqdn]
}

resource "aws_elb_listener" "https_listener" {
  count              = var.elb_name != null ? 1 : 0
  elb_name           = var.elb_name
  instance_port      = 80
  instance_protocol  = "HTTP"
  lb_port            = 443
  lb_protocol        = "HTTPS"
  ssl_certificate_id = aws_acm_certificate.cert.arn
}
