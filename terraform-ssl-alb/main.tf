module "ssl_cert" {
  source         = "./modules/ssl_cert_dns_record"
  domain_name    = "your.domain.com"
  hosted_zone_id = "Z123456ABCEXAMPLE"
  elb_name       = "your-elb-name"
  tags = {
    Environment = "dev"
    Owner       = "Oluwaseun"
  }
}
