/*
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = var.hosted_zone_id
  records = [each.value.value]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    for record in aws_route53_record.validation : record.fqdn
  ]
}

resource "null_resource" "attach_ssl_listener" {
  depends_on = [aws_acm_certificate_validation.cert_validation]

  triggers = {
    cert_arn = aws_acm_certificate.cert.arn
  }

  provisioner "local-exec" {
    command = <<EOT
      aws elb create-load-balancer-listeners \
        --load-balancer-name ${var.elb_name} \
        --listeners "Protocol=HTTPS,LoadBalancerPort=443,InstanceProtocol=HTTP,InstancePort=80,SSLCertificateId=${aws_acm_certificate.cert.arn}"
    EOT
  }
}
*/

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = var.hosted_zone_id
  records = [each.value.value]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    for record in aws_route53_record.validation : record.fqdn
  ]
}

resource "null_resource" "replace_tcp_with_https" {
  count      = var.use_https_listener ? 1 : 0
  depends_on = [aws_acm_certificate_validation.cert_validation]

  triggers = {
    cert_arn = aws_acm_certificate.cert.arn
    elb_name = var.elb_name
  }

  provisioner "local-exec" {
    command = <<EOT
      aws elb delete-load-balancer-listeners \
        --load-balancer-name ${var.elb_name} \
        --load-balancer-ports 443 || true

      aws elb create-load-balancer-listeners \
        --load-balancer-name ${var.elb_name} \
        --listeners "Protocol=HTTPS,LoadBalancerPort=443,InstanceProtocol=HTTP,InstancePort=80,SSLCertificateId=${aws_acm_certificate.cert.arn}"
    EOT
  }
}
