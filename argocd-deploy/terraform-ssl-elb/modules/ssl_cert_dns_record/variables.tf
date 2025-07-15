variable "domain_name" {
  description = "FQDN for ACM Certificate (e.g., argocd.oluwaseunalade.com)"
  type        = string
}

variable "zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
}

variable "elb_name" {
  description = "Name of the Classic Load Balancer"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
}