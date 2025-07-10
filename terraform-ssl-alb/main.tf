module "alb_ssl" {
  source = "./modules/alb_with_ssl"

  domain_name     = var.domain_name
  hosted_zone_id  = var.hosted_zone_id
  vpc_id          = var.vpc_id
  public_subnets  = var.public_subnets
  profile         = var.profile
}
