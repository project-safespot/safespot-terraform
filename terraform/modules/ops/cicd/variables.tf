variable "project" {
  type = string
  default = "safespot"
}

variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "env는 dev, stg, prod 중 하나여야 합니다."
  }
}

variable "github_org" {
  type = string
  default = "project-safespot"
}

variable "github_repos" {
  type = list(string)

  default = [
    "safespot-applicaton",
    "safespot-front"
  ]
}

variable "allowed_branches" {
  type = list(string)

  default = [ "main" ]
}

variable "allow_pull_request_oidc" {
  type    = bool
  default = false
}

variable "terraform_state_bucket" {
  type = string
}

variable "terraform_state_key_prefixes" {
  type = list(string)
}

variable "ecr_repository_arns" {
  type = list(string)
}

variable "enable_terraform_apply" {
  type    = bool
  default = false
}

variable "enable_argocd_eks_policy" {
  type    = bool
  default = false
}

variable "eks_cluster_name" {
  type    = string
  default = ""
}

variable "aws_region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "frontend_s3_bucket" {
  type = string
  default = ""
}

variable "cloudfront_distribution_id" {
  type = string
  default = ""
}