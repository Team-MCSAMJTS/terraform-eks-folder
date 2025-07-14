resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.6"  # latest stable version as of writing

  create_namespace = true
  timeout = 900  # Timeout in seconds (10 minutes)

  values = [
    file("${path.module}/argocd-values.yaml")
  ]
}