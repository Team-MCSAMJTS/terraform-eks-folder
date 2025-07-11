module "ssl_listener" {
  source = "./modules/ssl_listener"

  domain_name        = var.domain_name
  hosted_zone_id     = var.hosted_zone_id
  alb_arn            = var.alb_arn
  alb_zone_id        = var.alb_zone_id
  alb_dns_name       = var.alb_dns_name
  target_group_arn   = var.target_group_arn
}
