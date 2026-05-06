variable "environment" {
  description = "Environment name"
  type        = string
}

variable "github_org" {
  type = string
}

variable "github_repos" {
  type = list(string)
}

variable "terraform_state_bucket" {
  type = string
}

variable "terraform_state_key_prefixes" {
  type = list(string)
}

variable "ecr_repository_arns" {
  type    = list(string)
  default = []
}

variable "enable_argocd_eks_policy" {
  type    = bool
  default = false
}

variable "eks_cluster_name" {
  type    = string
  default = ""
}
