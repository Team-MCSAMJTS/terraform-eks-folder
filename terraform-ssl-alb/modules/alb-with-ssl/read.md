# Making the Module Reusable Elsewhere
# You can copy modules/alb_with_ssl to any Terraform project and do:

module "my_alb" {
  source         = "./modules/alb_with_ssl"
  domain_name    = "app.mydomain.com"
  hosted_zone_id = "Zxxxxxxx"
  vpc_id         = "vpc-xxxx"
  public_subnets = ["subnet-xxx", "subnet-yyy"]
  profile        = "default"
}



