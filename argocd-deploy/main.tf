/*
resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.6"  # latest stable version as of writing

  create_namespace = true
  timeout = 900  # Timeout in seconds (10 minutes)

  values = [
    file("${path.module}/argocd-values.yaml")
  ]
}
*/


# 1. Install ArgoCD using Helm
resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.46.6"
  create_namespace = true
  timeout          = 900

  values = [
    file("${path.module}/argocd-values.yaml")
  ]
}

# 2. Issue ACM cert and attach it to ArgoCD ELB
module "argocd_ssl_cert" {
  source             = "../terraform-ssl-elb/modules/ssl_cert_dns_record"
  domain_name        = "argocd.oluwaseunalade.com"
  hosted_zone_id     = "Z01920241TQU6SU23PN1G"
  elb_name           = "a37045ec5a42b4215bfc40a9b9504a0c"  # ✅ Your actual ArgoCD Classic ELB name
  use_https_listener = true
  tags = {
    Environment = "dev"
    App         = "argocd"
  }
}

# 3. Route 53 alias pointing subdomain to ArgoCD ELB
resource "aws_route53_record" "argocd_alias" {
  zone_id = "Z01920241TQU6SU23PN1G"
  name    = "argocd.oluwaseunalade.com"
  type    = "A"

  alias {
    name                   = "a37045ec5a42b4215bfc40a9b9504a0c-468396401.ca-central-1.elb.amazonaws.com" # ✅ Replace if different
    zone_id                = "ZQSVJUPU6J1EY"  # ✅ Hosted zone ID for Classic ELB in ca-central-1
    evaluate_target_health = false
  }
}
