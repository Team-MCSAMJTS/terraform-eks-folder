
resource "helm_release" "argocd" {
  count            = var.env == "prod" ? 1 : 0
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.7.11"
  namespace        = kubernetes_namespace.argocd[0].metadata[0].name

  create_namespace   = true
  depends_on         = [kubernetes_namespace.argocd]
  skip_crds          = false
  disable_crd_hooks  = false
  dependency_update  = true

  timeout            = 2400
  wait               = true
  wait_for_jobs      = false

  values = [data.template_file.argo_values[0].rendered]
}
