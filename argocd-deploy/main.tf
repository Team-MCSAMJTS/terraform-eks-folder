# terraform-eks-folder/argocd-deploy/main.tf

module "ssl_cert" {
  source = "./terraform-ssl-elb/modules/ssl_cert"

  domain_name         = var.domain_name
  hosted_zone_id      = var.hosted_zone_id
  elb_name            = var.elb_name
  elb_dns_name        = var.elb_dns_name
  elb_zone_id         = var.elb_zone_id
  environment         = var.environment

  availability_zones  = var.availability_zones
  security_groups     = var.security_groups
  subnet_ids          = var.subnet_ids
}


resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.6"

  create_namespace = true
  timeout          = 900

  values = [
    file("${path.module}/argocd-values.yaml")
  ]
}


