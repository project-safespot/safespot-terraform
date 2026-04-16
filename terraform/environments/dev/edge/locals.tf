locals {
  domain = "edge"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Domain      = local.domain
    ManagedBy   = "terraform"
  }
}