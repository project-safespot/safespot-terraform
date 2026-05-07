variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "github_org" {
  type = string
}

variable "github_repos" {
  type = list(string)
}

variable "allowed_branches" {
  type = list(string)

  default = [
    "main",
    "infra/ops-cicd"
  ]
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