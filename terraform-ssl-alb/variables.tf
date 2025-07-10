variable "domain_name" {}
variable "hosted_zone_id" {}
variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "profile" {}
