module "alb_controller" {
  source       = "./modules/alb_controller"
  cluster_name = "your-eks-cluster-name"
  region       = "ca-central-1"
  vpc_id       = "your-vpc-id"  
}

module "argocd" {
  source         = "./modules/argocd"
  region         = "ca-central-1"
  argocd_domain  = "argocd.oluwaseunalade.com"
  hosted_zone_id = "Z01920241TQU6SU23PN1G" # Route53 zone ID for oluwaseunalade.com
}
