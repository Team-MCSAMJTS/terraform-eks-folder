variable "domain_name" {
  description = "Subdomain to generate certificate for (e.g., argocd.oluwaseunalade.com)"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "environment" {
  description = "Environment tag (dev, staging, prod)"
  type        = string
}

variable "elb_name" {
  description = "Name of the existing Classic Load Balancer"
  type        = string
}

variable "elb_dns_name" {
  description = "DNS name of the existing ELB"
  type        = string
}

variable "elb_zone_id" {
  description = "Zone ID of the existing ELB (used for alias)"
  type        = string
}
