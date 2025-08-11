# 🔐 Kubernetes HTTPS Setup with Cert-Manager and Let's Encrypt (Route 53 DNS)

This document describes how to secure a custom domain (`dev.aladeoluwaseun.com`)  using **cert-manager**, **Let’s Encrypt**, and **Ingress NGINX** with DNS challenge via AWS Route 53.

---

# 1. Run to Install cert-manager

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml


#2 Create AWS Credentials Secret --> aws-secret.yaml

apiVersion: v1
kind: Secret
metadata:
  name: route53-credentials-secret
  namespace: cert-manager
type: Opaque
stringData:
  AWS_ACCESS_KEY_ID: <your-access-key>
  AWS_SECRET_ACCESS_KEY: <your-secret-key>


#3 Create ClusterIssuer for Let’s Encrypt --> cluster-issuer.yaml

apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-dns
spec:
  acme:
    email: your@email.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-dns-private-key
    solvers:
    - dns01:
        route53:
          region: ca-central-1
          accessKeyIDSecretRef:
            name: route53-credentials-secret
            key: AWS_ACCESS_KEY_ID
          secretAccessKeySecretRef:
            name: route53-credentials-secret
            key: AWS_SECRET_ACCESS_KEY


#4 Run Ingress NGINX Controller 52-59

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace


# 5. create --> ingress.yaml 
#Create Ingress with TLS and Auto Certificate

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: default
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-dns
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - dev.charlesabe.com  #replace with your domain#
    secretName: dev-charlesabe-com-tls
  rules:
  - host: dev.charlesabe.com   #replace with your domain#
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80


# 6 Now run
kubectl apply -f .

# 7 to get the svc ingress loadbalancer#
kubectl get svc -n ingress-nginx

# 8 Now ensure you delete the old loadbalancer, created initially using
kubectl delete svc frontend-external -n default

# 9 Point Route 53 to Ingress Load Balancer

In AWS Route 53:

Create A/ALIAS record for dev.aladeoluwaseun.com  #replace with your domain#

# 10 Target → ELB DNS from kubectl get svc -n ingress-nginx and replace it with the existing loadbalncer in A-record of route 53#

# 11 Verify HTTPS
curl -v https://dev.aladeoluwaseun.com   #replace with your domain#

Or test on SSL Labs


