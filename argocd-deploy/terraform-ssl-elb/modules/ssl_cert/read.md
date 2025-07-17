# aws elb describe-load-balancers \
  --load-balancer-names your-elb-name \
  --query "LoadBalancerDescriptions[0].[DNSName, CanonicalHostedZoneNameID]" \
  --region ca-central-1

# Get your Classic ELB name:
aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName"

# How to get your hosted_zone_id
aws route53 list-hosted-zones-by-name --dns-name oluwaseunalade.com


