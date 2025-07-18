#
# Provider Configuration
#

provider "aws" {
  region  = "ca-central-1"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}

#backend
terraform {
  backend "s3" {
    region = "ca-central-1"
    workspace_key_prefix = "microservices"
    key    = "terraform.tfstate"
    bucket = "fashion-project-bucket"
  }
}

