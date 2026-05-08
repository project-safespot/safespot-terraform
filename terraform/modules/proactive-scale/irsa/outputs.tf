output "irsa_role_arn" {
  description = "IAM Role ARN for proactive-scale-controller IRSA. Used in K8s ServiceAccount annotation."
  value       = aws_iam_role.proactive_scale_controller.arn
}

output "irsa_role_name" {
  description = "IAM Role name for proactive-scale-controller IRSA."
  value       = aws_iam_role.proactive_scale_controller.name
}
