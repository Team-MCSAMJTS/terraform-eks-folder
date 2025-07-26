# to run the application
# Comment out module and record, then:............IMPORTANT NOTE..........
terraform init
terraform apply --auto-approve -var-file="terraform.tfvars"

#if login in through localhost 
kubectl port-forward svc/argocd-server -n argocd 8080:443

# argocd password
ausername : admin
# to get password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo
# The DNS name of your ELB
kubectl get svc -n argocd

# Run this to list all Classic ELBs:
aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].{Name:LoadBalancerName, DNS:DNSName}" --output table

# Hosted Zone ID for your ELB DNS name
aws elb describe-load-balancers \
  --query "LoadBalancerDescriptions[?DNSName=='a37045ec5a42b4215bfc40a9b9504a0c-468396401.ca-central-1.elb.amazonaws.com'].CanonicalHostedZoneNameID" \
  --output text
