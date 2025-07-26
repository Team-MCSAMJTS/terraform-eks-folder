module "ssl_cert" {
  source         = "./modules/ssl_cert_dns_record"
  domain_name    = "dev.oluwaseunalade.com"
  hosted_zone_id = "Z01920241TQU6SU23PN1G"
  elb_name       = "a73ba8eea68c9416e8d2fddd1dbb6f28"
  tags = {
    Environment = "dev"
    Owner       = "Oluwaseun"
  }
}

/*
module "grpc_cert" {
  source             = "../modules/ssl_cert_dns_record"
  domain_name        = "grpc.oluwaseunalade.com"
  hosted_zone_id     = "ZXXXXXXXXXXXXXX"
  elb_name           = "my-elb-name"
  use_https_listener = false
}
*/