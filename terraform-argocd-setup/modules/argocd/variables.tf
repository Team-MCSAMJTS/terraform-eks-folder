variable "region" {
  type        = string
  default     = "ca-central-1"
  description = "AWS region"
}

variable "argocd_domain" {
  type        = string
  description = "The domain name for ArgoCD (e.g. argocd.oluwaseunalade.com)"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route53 Hosted Zone ID for the root domain (e.g. oluwaseunalade.com)"
}
