data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Slack Webhook URL은 Terraform으로 관리하지 않습니다.
# 아래 이름으로 SSM Parameter Store에 직접 입력하세요 (Type: SecureString).
# aws ssm put-parameter \
#   --name "$(terraform output -raw slack_webhook_secret_name)" \
#   --value "https://hooks.slack.com/services/..." \
#   --type "SecureString"

resource "aws_iam_policy" "alertmanager_secret_read" {
  count = var.enable_slack_secret ? 1 : 0

  name = "${local.name_prefix}-alertmanager-secret-read"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSSMParameterRead"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:DescribeParameters"
        ]
        Resource = "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${local.slack_secret_name}"
      }
    ]
  })
}
