output "argocd_url" {
  description = "Access URL for Argo CD"
  value       = "https://${var.argocd_domain}"
}
