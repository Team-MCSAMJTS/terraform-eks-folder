variable "domain_name" {
  description = "The domain to secure with ACM"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "elb_name" {
  description = "The Classic Load Balancer name"
  type        = string
}

variable "elb_dns_name" {
  description = "The DNS name of the ELB"
  type        = string
}

variable "elb_zone_id" {
  description = "The zone ID of the ELB for Route53 alias"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

