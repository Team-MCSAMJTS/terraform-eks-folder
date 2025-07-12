# Get the Route 53 Hosted Zone ID like this:
aws route53 list-hosted-zones-by-name --dns-name example.com \
  --query "HostedZones[0].Id" --output text

# Get your Classic ELB name:
aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName"

