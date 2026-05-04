variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
}

variable "env" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "stg", "prod"], var.env)
    error_message = "env는 dev, stg, prod 중 하나여야 합니다."
  }
}

variable "github_org" {
  type = string

  validation {
    condition     = length(var.github_org) > 0
    error_message = "github_org는 필수입니다."
  }
}

variable "github_repos" {
  type = list(string)

  validation {
    condition     = length(var.github_repos) > 0
    error_message = "github_repos는 최소 1개 이상 필요합니다."
  }
}

variable "terraform_state_bucket" {
  type    = string
  default = "safespot-terraform-state"

  validation {
    condition     = length(var.terraform_state_bucket) > 0
    error_message = "terraform_state_bucket은 필수입니다."
  }
}

variable "ecr_repository_arns" {
  description = "ops remote state를 참조하지 못하는 초기 bootstrap 상황에서 직접 주입할 ECR Repository ARN 목록"
  type        = list(string)
  default     = []
}

variable "enable_argocd_eks_policy" {
  description = "GitHub Actions 또는 ArgoCD가 EKS 접근 권한이 필요한 경우 true"
  type        = bool
  default     = false
}

variable "eks_cluster_name" {
  description = "enable_argocd_eks_policy = true일 때 사용할 EKS Cluster 이름"
  type        = string
  default     = ""
}