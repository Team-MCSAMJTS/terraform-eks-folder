module "ssl_cert" {
  source         = "./modules/ssl_cert_dns_record"
  domain_name    = "dev.oluwaseunalade.com"
  hosted_zone_id = "Z01920241TQU6SU23PN1G"
  elb_name       = "a4406d70ca67546da90659ecc70f86e8"
  tags = {
    Environment = "dev"
    Owner       = "Oluwaseun"
  }
}
