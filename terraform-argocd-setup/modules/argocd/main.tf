resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "aws_acm_certificate" "argocd_cert" {
  domain_name       = var.argocd_domain
  validation_method = "DNS"

  tags = {
    Name = "argocd-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.argocd_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.argocd_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"

  values = [yamlencode({
    server = {
      ingress = {
        enabled           = true
        ingressClassName = "alb"
        annotations = {
          "alb.ingress.kubernetes.io/scheme"              = "internet-facing"
          "alb.ingress.kubernetes.io/target-type"         = "ip"
          "alb.ingress.kubernetes.io/listen-ports"        = "[{\"HTTPS\":443}]"
          "alb.ingress.kubernetes.io/certificate-arn"     = aws_acm_certificate_validation.cert.certificate_arn
          "alb.ingress.kubernetes.io/ssl-redirect"        = "443"
          "alb.ingress.kubernetes.io/group.name"          = "argocd"
        }
        hosts = [var.argocd_domain]
        paths = [{
          path     = "/*"
          pathType = "ImplementationSpecific"
        }]
      }
    }
  })]

  depends_on = [
    kubernetes_namespace.argocd,
    aws_acm_certificate_validation.cert
  ]
}
