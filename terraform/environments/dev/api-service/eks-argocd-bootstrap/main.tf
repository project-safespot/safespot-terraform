module "argocd_bootstrap" {
  source = "../../../../modules/api-service/argocd-bootstrap"

  argocd_namespace     = var.argocd_namespace
  argocd_chart_version = var.argocd_chart_version

  repo_url        = var.repo_url
  target_revision = var.target_revision
  addons_path     = var.addons_path
}
