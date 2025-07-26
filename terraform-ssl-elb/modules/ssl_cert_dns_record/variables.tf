/*
variable "domain_name" {
  description = "The domain name to request an SSL certificate for."
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID for the domain."
  type        = string
}

variable "elb_name" {
  description = "The Classic ELB name to attach the certificate to. Optional."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

# Another section

variable "domain_name" {
  description = "The domain name to request an SSL certificate for."
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID for the domain."
  type        = string
}

variable "elb_name" {
  description = "The Classic ELB name to attach the certificate to."
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
*/

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID where the domain is managed"
  type        = string
}

variable "elb_name" {
  description = "Name of the Classic Load Balancer to apply SSL to"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "use_https_listener" {
  description = "If true, replace TCP:443 with HTTPS:443 on ELB"
  type        = bool
  default     = false
}
