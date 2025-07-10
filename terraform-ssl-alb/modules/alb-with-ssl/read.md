# Making the Module Reusable Elsewhere
# You can copy modules/alb_with_ssl to any Terraform project and do:

module "my_alb" {
  source         = "./modules/alb_with_ssl"
  domain_name    = "app.mydomain.com"
  hosted_zone_id = "Zxxxxxxx"
  vpc_id         = "vpc-xxxx"
  public_subnets = ["subnet-xxx", "subnet-yyy"]
  profile        = "default"
}

command to get :
hosted_zone_id > aws route53 list-hosted-zones --query "HostedZones[*].{Name:Name,Id:Id}" --output table
e.g   Your hosted_zone_id is Z1XYZEXAMPLE123 (strip /hostedzone/ prefix if needed)

vpc_id > aws ec2 describe-vpcs --query "Vpcs[*].{VpcId:VpcId,Cidr:CidrBlock}" --output table
OR (If you want to filter by tag (e.g., Name=main-vpc):)
aws ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=main-vpc" \
  --query "Vpcs[0].VpcId" \
  --output text

public_subnets > 
aws ec2 describe-subnets \
  --query "Subnets[*].{SubnetId:SubnetId,AZ:AvailabilityZone,CIDR:CidrBlock}" \
  --output table

To filter only public subnets:
If you tag your public subnets (e.g., Tier=public):

aws ec2 describe-subnets \
  --filters "Name=tag:Tier,Values=public" \
  --query "Subnets[*].SubnetId" \
  --output json
