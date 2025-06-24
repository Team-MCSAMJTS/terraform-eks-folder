module "ecr-repo" {
  source           = "./../modules/ecr"
  ecr_name         = var.ecr_name
  tags             = var.tags
  image_mutability = var.image_mutability

}

# run terraform plan -var-file="ecr.tfvars"
#     terraform apply -var-file="ecr.tfvars"
#     terraform destroy -var-file="ecr.tfvars"