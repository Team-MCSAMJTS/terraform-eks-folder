module "ssl_cert" {
  source         = "./modules/ssl_cert_dns_record"
  domain_name    = "dev.oluwaseunalade.com"
  hosted_zone_id = "Z01920241TQU6SU23PN1G"
  elb_name       = "a5e36b9b49de3466388a8545f9f95c88"
  tags = {
    Environment = "dev"
    Owner       = "Oluwaseun"
  }
}
