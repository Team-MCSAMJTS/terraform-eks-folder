module "ssl_cert" {
  source = "../modules/ssl_cert"

  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
  elb_name       = var.elb_name
  elb_dns_name   = var.elb_dns_name
  elb_zone_id    = var.elb_zone_id
  environment    = var.environment
}

