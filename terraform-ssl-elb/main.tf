module "ssl_cert" {
  source         = "./modules/ssl_cert_dns_record"
  domain_name    = "dev.oluwaseunalade.com"
  hosted_zone_id = "Z01920241TQU6SU23PN1G"
  elb_name       = "ac18ec9d170224846b82d516bb7e8eda"
  tags = {
    Environment = "dev"
    Owner       = "Oluwaseun"
  }
}
