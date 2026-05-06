locals {
  domain      = "ops"
  name_prefix = "${var.project}-${var.environment}-${local.domain}"

  github_oidc_url        = "https://token.actions.githubusercontent.com"
  github_oidc_host       = "token.actions.githubusercontent.com"
  github_oidc_thumbprint = "6938fd4d98bab03faadb97b34396831e3780aea1"

  account_id = data.aws_caller_identity.current.account_id

  terraform_state_object_arns = [
    for prefix in var.terraform_state_key_prefixes :
    "arn:aws:s3:::${var.terraform_state_bucket}/${prefix}/*"
  ]
}
