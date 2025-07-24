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

provider "aws" {
  region = "ca-central-1"
}

# Step 1: Install ArgoCD via Helm
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

# Step 2: Provision SSL Certificate using your shared module
module "argocd_ssl_cert" {
  source         = "../terraform-ssl-elb/modules/ssl_cert_dns_record"
  domain_name    = "argocd.oluwaseunalade.com"
  hosted_zone_id = "Z01920241TQU6SU23PN1G"
  elb_name       = "a73ba8eea68c9416e8d2fddd1dbb6f28"  # 🔁 Replace this with the actual ELB name after Helm deploys

  tags = {
    Environment = "dev"
    Owner       = "Oluwaseun"
    App         = "argocd"
  }
}

# Step 3: Optional but recommended - Route53 Alias Record for the ArgoCD subdomain
resource "aws_route53_record" "argocd_alias" {
  zone_id = "Z01920241TQU6SU23PN1G"
  name    = "argocd.oluwaseunalade.com"
  type    = "A"

  alias {
    name                   = "a73ba8eea68c9416e8d2fddd1dbb6f28.ca-central-1.elb.amazonaws.com"  # 🔁 Replace with actual ELB DNS name
    zone_id                = "Z35SXDOTRQ7X7K"  # 🔍 This is the Hosted Zone ID for Classic ELB in ca-central-1
    evaluate_target_health = false
  }
}
