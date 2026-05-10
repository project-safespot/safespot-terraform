locals {
  project     = "safespot"
  domain      = "ops"
  name_prefix = "${local.project}-${var.env}-${local.domain}"

  services = [
    "api-core",
    "api-public-read",
    "external-ingestion",
    "pre-scaling-controller",
  ]

  log_retention_days = 30

  remote_state_bucket = "safespot-terraform-state"
  remote_state_region = "ap-northeast-2"
}