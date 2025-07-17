provider "aws" {
  region = "us-east-1"
}

# 1. Create ACM Certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.environment}-ssl-cert"
  }
}

# 2. Create DNS Validation Record
resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  zone_id = var.hosted_zone_id
  records = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
  ttl     = 60
}

# 3. Wait for Certificate Validation
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

# 4. Create HTTPS Listener on ELB
resource "aws_elb_listener" "https" {
  load_balancer_name = var.elb_name
  instance_port      = 80
  instance_protocol  = "HTTP"
  lb_port            = 443
  lb_protocol        = "HTTPS"
  ssl_certificate_id = aws_acm_certificate.cert.arn
}

# 5. Create Route53 A Record (Alias to ELB)
resource "aws_route53_record" "a_record" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.elb_dns_name
    zone_id                = var.elb_zone_id
    evaluate_target_health = true
  }
}
