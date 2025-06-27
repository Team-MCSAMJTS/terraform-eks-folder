variable "env" {
  default = "prod"
}

data "template_file" "argo-values" {
  count    = var.env == "prod" ? 1 : 0
  template = file("${path.module}/argocd-values.yaml")
}

resource "kubernetes_namespace" "argocd" {
  count = var.env == "prod" ? 1 : 0

  metadata {
    name = "argocd-${var.env}"
  }
}

resource "helm_release" "argocd" {
  count      = var.env == "prod" ? 1 : 0
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "6.7.11"
  timeout    = "1500"
  namespace  = kubernetes_namespace.argocd[0].metadata[0].name
  values     = [data.template_file.argo-values[0].rendered]
}

resource "null_resource" "password" {
  count = var.env == "prod" ? 1 : 0
  provisioner "local-exec" {
  command = "kubectl -n argocd-${var.env} get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d > argocd-login.txt"
}

}

resource "null_resource" "del-argo-pass" {
  count = var.env == "prod" ? 1 : 0

  provisioner "local-exec" {
    command = "kubectl -n argocd-${var.env} delete secret argocd-initial-admin-secret || true"
  }

  depends_on = [null_resource.password]
}



