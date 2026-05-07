data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "terraform_remote_state" "ops" {
  backend = "s3"

  config = {
    bucket = local.remote_state_bucket
    key    = "environments/${var.environment}/ops/terraform.tfstate"
    region = local.remote_state_region
  }
}

data "terraform_remote_state" "api_service" {
  count   = var.enable_argocd_eks_policy ? 1 : 0
  backend = "s3"

  config = {
    bucket = local.remote_state_bucket
    key    = "environments/${var.environment}/api-service/eks-core/terraform.tfstate"
    region = local.remote_state_region
  }
}

module "cicd" {
  source = "../../../modules/ops/cicd"

  project      = var.project
  environment  = var.environment
  github_org   = var.github_org
  github_repos = var.github_repos

  ecr_push_repos        = var.ecr_push_repos
  terraform_repos       = var.terraform_repos
  frontend_deploy_repos = var.frontend_deploy_repos

  terraform_state_bucket       = var.terraform_state_bucket
  terraform_state_key_prefixes = local.terraform_state_key_prefixes

  account_id       = data.aws_caller_identity.current.account_id
  aws_region       = data.aws_region.current.name
  common_tags      = var.common_tags
  allowed_branches = var.allowed_branches

  allow_pull_request_oidc  = var.allow_pull_request_oidc
  enable_terraform_apply   = var.enable_terraform_apply
  enable_argocd_eks_policy = var.enable_argocd_eks_policy
  eks_cluster_name         = local.cluster_name

  ecr_repository_arns        = local.ecr_repository_arns
  frontend_s3_bucket         = var.frontend_s3_bucket
  cloudfront_distribution_id = var.cloudfront_distribution_id
  ssm_kms_key_arn            = var.ssm_kms_key_arn
}
