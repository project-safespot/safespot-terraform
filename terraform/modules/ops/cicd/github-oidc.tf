# modules/ops/cicd/github-oidc.tf
#
# AWS provider 5.x부터 GitHub OIDC thumbprint 검증을 AWS 측에서 처리한다.
# thumbprint_list = [] 로 설정해도 정상 동작한다.
# 하드코딩된 thumbprint는 GitHub 인증서 교체 시 OIDC 인증 전체 차단 위험이 있다.

resource "aws_iam_openid_connect_provider" "github" {
  url = local.github_oidc_url

  client_id_list = [
    "sts.amazonaws.com"
  ]

  # AWS provider 5.x: thumbprint 검증은 AWS가 처리하므로 빈 리스트로 설정
  thumbprint_list = []

  tags = {
    Name        = "${local.name_prefix}-iam-oidc-github"
    Project     = var.project
    Environment = var.environment
    Domain      = local.domain
    ManagedBy   = "terraform"
    Service     = "github-actions"
    CostCenter  = "${var.project}-${var.environment}"
  }
}
