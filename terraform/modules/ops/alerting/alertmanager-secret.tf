resource "aws_ssm_parameter" "slack_webhook" {
  count = var.enable_slack_secret ? 1 : 0

  name        = local.slack_secret_name
  description = "AlertManager Slack Webhook URL for ${local.name_prefix}"
  type        = "SecureString"
  value       = var.slack_webhook_url != "" ? var.slack_webhook_url : "placeholder"

  tags = {
    Name        = local.slack_secret_name
    Project     = var.project
    Environment = var.environment
    Domain      = local.domain
    ManagedBy   = "terraform"
  }
}

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
        Resource = aws_ssm_parameter.slack_webhook[0].arn
      }
    ]
  })
}
