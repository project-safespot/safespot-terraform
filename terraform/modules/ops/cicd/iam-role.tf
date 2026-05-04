resource "aws_iam_role" "github_actions" {
  for_each = toset(var.github_repos)

  name        = "${local.name_prefix}-iam-role-gha-${replace(each.key, "/", "-")}"
  description = "GitHub Actions OIDC Role for ${each.key}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowGitHubActionsOIDC"
        Effect = "Allow"

        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "${local.github_oidc_host}:aud" = "sts.amazonaws.com"
          }

          StringLike = {
            "${local.github_oidc_host}:sub" = [
              "repo:${each.key}:ref:refs/heads/main",
              "repo:${each.key}:pull_request"
            ]
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${local.name_prefix}-iam-role-gha-${replace(each.key, "/", "-")}"
    Project     = local.project
    Environment = var.env
    Domain      = local.domain
    ManagedBy   = "terraform"
    Service     = "github-actions"
    CostCenter  = "${local.project}-${var.env}"
    Repository  = each.key
  }
}