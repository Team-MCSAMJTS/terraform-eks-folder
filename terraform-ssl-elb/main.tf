module "ssl_cert" {
  source         = "./modules/ssl_cert_dns_record"
  domain_name    = "dev.oluwaseunalade.com"
  hosted_zone_id = "Z01920241TQU6SU23PN1G"
  elb_name       = "a96edfc7bbe974b6eb1389c8a2a2bec0"
  tags = {
    Environment = "dev"
    Owner       = "Oluwaseun"
  }
}
