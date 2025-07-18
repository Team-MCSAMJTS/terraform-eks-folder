variable "domain_name" {
  description = "The full domain name to secure"
  type        = string
}

variable "hosted_zone_id" {
  description = "The ID of the Route53 hosted zone"
  type        = string
}

variable "elb_name" {
  description = "Name of the Classic ELB"
  type        = string
}

variable "elb_dns_name" {
  description = "DNS name of the ELB for Route53 alias"
  type        = string
}

variable "elb_zone_id" {
  description = "Canonical hosted zone ID of the ELB"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use for the ELB"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs to associate with the ELB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ELB"
  type        = list(string)
}
