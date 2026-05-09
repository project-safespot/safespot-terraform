module "prometheus_irsa" {
  count  = var.enable_prometheus_irsa ? 1 : 0
  source = "../../../modules/api-service/eks-irsa"

  role_name            = "${local.name_prefix}-prometheus-irsa"
  oidc_provider_arn    = var.eks_oidc_provider_arn
  oidc_provider        = var.eks_oidc_provider_url
  namespace            = var.prometheus_namespace
  service_account_name = var.prometheus_service_account_name

  managed_policy_arns = {
    cloudwatch_read = aws_iam_policy.cloudwatch_read[0].arn
  }
}

resource "aws_ssm_parameter" "prometheus_irsa_role_arn" {
  count = var.enable_prometheus_irsa ? 1 : 0

  name        = "/${var.project}/${var.environment}/observability/prometheus/irsa-role-arn"
  description = "Prometheus IRSA Role ARN for CloudWatch metrics read"
  type        = "String"
  value       = module.prometheus_irsa[0].role_arn

  overwrite = true

  tags = {
    Name    = "/${var.project}/${var.environment}/observability/prometheus/irsa-role-arn"
    Purpose = "prometheus-irsa-role-arn"
  }
}
