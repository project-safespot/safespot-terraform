# ── EKS OIDC Provider 참조 ────────────────────────────────────────
data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}

data "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

locals {
  oidc_issuer = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
  sa_subject  = "system:serviceaccount:${var.k8s_namespace}:${var.k8s_service_account_name}"
}

# ── IRSA IAM Role ─────────────────────────────────────────────────
# K8s ServiceAccount의 토큰을 AssumeRoleWithWebIdentity로 교환하여 AWS 권한 획득
resource "aws_iam_role" "proactive_scale_controller" {
  name = "${var.project}-${var.environment}-proactive-scale-controller-irsa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = data.aws_iam_openid_connect_provider.eks.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${local.oidc_issuer}:sub" = local.sa_subject
          "${local.oidc_issuer}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })

  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-proactive-scale-controller-irsa"
  })
}

# ── SQS 최소 권한 정책 ────────────────────────────────────────────
# ReceiveMessage + DeleteMessage + GetQueueAttributes: 소비자 최소 권한
# ChangeMessageVisibility: visibility timeout 연장 (처리 지연 시)
# proactive-scale-queue ARN만으로 범위 제한 (DLQ 접근 불필요)
resource "aws_iam_role_policy" "sqs_consume" {
  name = "${var.project}-${var.environment}-proactive-scale-controller-sqs"
  role = aws_iam_role.proactive_scale_controller.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "ProactiveScaleSqsConsume"
      Effect = "Allow"
      Action = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:ChangeMessageVisibility"
      ]
      Resource = [var.proactive_scale_queue_arn]
    }]
  })
}
