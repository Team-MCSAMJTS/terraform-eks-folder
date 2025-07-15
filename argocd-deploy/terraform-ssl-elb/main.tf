module "ssl_cert" {
   source      = "./modules/ssl_cert_dns_record"
   domain_name = "argocd.oluwaseunalade.com"
   zone_id     = "Z01920241TQU6SU23PN1G"
   elb_name    = "a476e4c98127e40d29dd168d95057fd6"
   environment = "dev"
}