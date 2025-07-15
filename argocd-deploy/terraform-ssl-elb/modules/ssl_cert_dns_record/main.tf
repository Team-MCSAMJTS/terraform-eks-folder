resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = var.environment
    Owner       = "Oluwaseun"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}

resource "null_resource" "attach_ssl_listener" {
  depends_on = [aws_acm_certificate_validation.cert_validation]

  provisioner "local-exec" {
    command = <<EOT
EXISTING_CERT=$(aws elb describe-load-balancers --load-balancer-name ${var.elb_name} --query 'LoadBalancerDescriptions[].ListenerDescriptions[].Listener.SSLCertificateId' --output text)
if [ "$EXISTING_CERT" != "${aws_acm_certificate.cert.arn}" ]; then
  echo "Updating SSL certificate on ELB ${var.elb_name}..."
  aws elb set-load-balancer-listener-ssl-certificate \
    --load-balancer-name ${var.elb_name} \
    --load-balancer-port 443 \
    --ssl-certificate-id ${aws_acm_certificate.cert.arn}
else
  echo "ELB already using the desired certificate. Skipping."
fi
EOT
  }
}