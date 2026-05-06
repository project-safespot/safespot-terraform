data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_policy" "ecr_push" {
  name = "${local.name_prefix}-iam-policy-ecr-push"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowECRLogin"
        Effect   = "Allow"
        Action   = "ecr:GetAuthorizationToken"
        Resource = "*"
      },
      {
        Sid    = "AllowECRPush"
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Resource = length(var.ecr_repository_arns) > 0 ? var.ecr_repository_arns : [
          "arn:aws:ecr:${data.aws_region.current.name}:${local.account_id}:repository/${local.project}-${var.environment}-${local.domain}-ecr-*"
        ]
      }
    ]
  })

  tags = {
    Name        = "${local.name_prefix}-iam-policy-ecr-push"
    Project     = local.project
    Environment = var.environment
    Domain      = local.domain
    ManagedBy   = "terraform"
    Service     = "github-actions"
    CostCenter  = "${local.project}-${var.environment}"
  }
}

resource "aws_iam_policy" "terraform_state" {
  name = "${local.name_prefix}-iam-policy-terraform-state"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowS3StateBucketList"
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::${var.terraform_state_bucket}"
      },
      {
        Sid    = "AllowS3StateObjects"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = local.terraform_state_object_arns
      }
    ]
  })

  tags = {
    Name        = "${local.name_prefix}-iam-policy-terraform-state"
    Project     = local.project
    Environment = var.environment
    Domain      = local.domain
    ManagedBy   = "terraform"
    Service     = "terraform-state"
    CostCenter  = "${local.project}-${var.environment}"
  }
}

resource "aws_iam_policy" "terraform_infra" {
  name = "${local.name_prefix}-iam-policy-terraform-infra"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudWatch"
        Effect = "Allow"
        Action = [
          "cloudwatch:*Alarm*",
          "cloudwatch:*Dashboard*",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData",
          "logs:CreateLogGroup",
          "logs:DeleteLogGroup",
          "logs:PutRetentionPolicy",
          "logs:DescribeLogGroups",
          "logs:TagLogGroup",
          "logs:UntagLogGroup"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowSNS"
        Effect = "Allow"
        Action = [
          "sns:CreateTopic",
          "sns:DeleteTopic",
          "sns:GetTopicAttributes",
          "sns:SetTopicAttributes",
          "sns:Subscribe",
          "sns:Unsubscribe",
          "sns:ListSubscriptionsByTopic",
          "sns:TagResource",
          "sns:UntagResource"
        ]
        Resource = "arn:aws:sns:*:${local.account_id}:${local.name_prefix}-sns-*"
      },
      {
        Sid    = "AllowECRManage"
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:DeleteRepository",
          "ecr:DescribeRepositories",
          "ecr:PutLifecyclePolicy",
          "ecr:GetLifecyclePolicy",
          "ecr:DeleteLifecyclePolicy",
          "ecr:PutImageTagMutability",
          "ecr:PutImageScanningConfiguration",
          "ecr:TagResource",
          "ecr:UntagResource",
          "ecr:ListTagsForResource"
        ]
        Resource = "arn:aws:ecr:*:${local.account_id}:repository/${local.project}-${var.environment}-${local.domain}-ecr-*"
      },
      {
        Sid    = "AllowIAM"
        Effect = "Allow"
        Action = [
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:GetRole",
          "iam:UpdateAssumeRolePolicy",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:CreatePolicyVersion",
          "iam:DeletePolicyVersion",
          "iam:ListPolicyVersions",
          "iam:ListAttachedRolePolicies",
          "iam:TagRole",
          "iam:UntagRole",
          "iam:TagPolicy",
          "iam:UntagPolicy",
          "iam:CreateOpenIDConnectProvider",
          "iam:DeleteOpenIDConnectProvider",
          "iam:GetOpenIDConnectProvider",
          "iam:UpdateOpenIDConnectProviderThumbprint",
          "iam:TagOpenIDConnectProvider",
          "iam:UntagOpenIDConnectProvider"
        ]
        Resource = [
          "arn:aws:iam::${local.account_id}:role/${local.name_prefix}-iam-role-*",
          "arn:aws:iam::${local.account_id}:policy/${local.name_prefix}-iam-policy-*",
          "arn:aws:iam::${local.account_id}:oidc-provider/*"
        ]
      },
      {
        Sid    = "AllowSecretsManager"
        Effect = "Allow"
        Action = [
          "secretsmanager:CreateSecret",
          "secretsmanager:DeleteSecret",
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecret",
          "secretsmanager:TagResource",
          "secretsmanager:UntagResource"
        ]
        Resource = "arn:aws:secretsmanager:*:${local.account_id}:secret:safespot/*"
      },
      {
        Sid      = "AllowSTSGetCallerIdentity"
        Effect   = "Allow"
        Action   = "sts:GetCallerIdentity"
        Resource = "*"
      }
    ]
  })

  tags = {
    Name        = "${local.name_prefix}-iam-policy-terraform-infra"
    Project     = local.project
    Environment = var.environment
    Domain      = local.domain
    ManagedBy   = "terraform"
    Service     = "terraform"
    CostCenter  = "${local.project}-${var.environment}"
  }
}

resource "aws_iam_role_policy_attachment" "ecr_push" {
  for_each = aws_iam_role.github_actions

  role       = each.value.name
  policy_arn = aws_iam_policy.ecr_push.arn
}

resource "aws_iam_role_policy_attachment" "terraform_state" {
  for_each = aws_iam_role.github_actions

  role       = each.value.name
  policy_arn = aws_iam_policy.terraform_state.arn
}

resource "aws_iam_role_policy_attachment" "terraform_infra" {
  for_each = aws_iam_role.github_actions

  role       = each.value.name
  policy_arn = aws_iam_policy.terraform_infra.arn
}
