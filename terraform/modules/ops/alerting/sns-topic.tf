data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "ops_alert" {
  name              = local.sns_topic_name
  kms_master_key_id = "alias/aws/sns"

  tags = {
    Name        = local.sns_topic_name
    Project     = local.project
    Environment = var.environment
    Domain      = local.domain
    ManagedBy   = "terraform"
    Service     = "alerting"
    CostCenter  = "${local.project}-${var.environment}"
  }
}

resource "aws_sns_topic_policy" "ops_alert" {
  arn = aws_sns_topic.ops_alert.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudWatchAlarms"
        Effect = "Allow"
        Principal = {
          Service = var.allowed_aws_services
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.ops_alert.arn
        Condition = {
          StringEquals = {
            "AWS:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}
