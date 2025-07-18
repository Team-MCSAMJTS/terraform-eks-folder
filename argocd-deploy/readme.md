terraform init
terraform apply --auto-approve -var-file="terraform.tfvars"

#if login in through localhost 
kubectl port-forward svc/argocd-server -n argocd 8080:443

#argocd password
ausername : admin
#to get password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo

# Run this to get your Hosted Zone ID:
aws route53 list-hosted-zones-by-name \
  --dns-name oluwaseunalade.com \
  --query "HostedZones[0].Id" \
  --output text
# Run this to get ELB DNS name and zone ID:
aws elb describe-load-balancers \
  --load-balancer-name your-elb-name \
  --query "LoadBalancerDescriptions[0].[DNSName, CanonicalHostedZoneNameID]"
