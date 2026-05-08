variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name for OIDC provider lookup"
  type        = string
}

variable "proactive_scale_queue_arn" {
  description = "Proactive scale SQS queue ARN for IAM policy"
  type        = string
}

# K8s ServiceAccount와 매핑되는 namespace/name
# RoleBinding 대상과 일치해야 함
variable "k8s_namespace" {
  description = "Kubernetes namespace where proactive-scale-controller is deployed"
  type        = string
  default     = "application"
}

variable "k8s_service_account_name" {
  description = "Kubernetes ServiceAccount name"
  type        = string
  default     = "proactive-scale-controller"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
