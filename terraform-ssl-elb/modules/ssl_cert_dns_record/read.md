# before running SSL 
ensure to comment out 148-176
uncomment 109-146
when you are done then uncomment 148-176 and apply frontend.yml 
update dev k8s with certificate and edit A-record in aws

# Get the Route 53 Hosted Zone ID like this:
aws route53 list-hosted-zones-by-name --dns-name example.com \
  --query "HostedZones[0].Id" --output text

# Get your Classic ELB name:
aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName"

