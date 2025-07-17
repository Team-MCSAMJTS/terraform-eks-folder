module "ssl_cert" {
  source         = "./modules/ssl_cert"
  domain_name    = "argocd.oluwaseunalade.com"
  hosted_zone_id = "ZXXXXXXXXXX"   # Your hosted zone ID
  environment    = "dev"
  elb_name       = "your-elb-name" # Your existing ELB name
  elb_dns_name   = "a1234567890.elb.ca-central-1.amazonaws.com"
  elb_zone_id    = "Z35SXDOTRQ7X7K"  # ELB zone ID from AWS
}
