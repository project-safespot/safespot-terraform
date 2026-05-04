resource "aws_secretsmanager_secret" "slack_webhook" {
  count = var.enable_slack_secret ? 1 : 0

  name        = local.slack_secret_name
  description = "SafeSpot ${var.env} AlertManager Slack Webhook URL"

  recovery_window_in_days = var.slack_webhook_recovery_window_days

  tags = {
    Name    = local.slack_secret_name
    Purpose = "alertmanager-slack-webhook"
  }
}

resource "aws_secretsmanager_secret_version" "slack_webhook_placeholder" {
  count = var.enable_slack_secret ? 1 : 0

  secret_id = aws_secretsmanager_secret.slack_webhook[0].id

  secret_string = jsonencode({
    webhook_url = "REPLACE_ME"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_iam_policy" "alertmanager_secret_read" {
  count = var.enable_slack_secret ? 1 : 0

  name = "${local.name_prefix}-alertmanager-secret-read"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSecretRead"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.slack_webhook[0].arn
      }
    ]
  })
}