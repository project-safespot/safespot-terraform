locals {
  domain    = "ops"
  subdomain = "cicd"

  name_prefix = "${var.project}-${var.environment}-${local.domain}-${local.subdomain}"

  remote_state_bucket = var.terraform_state_bucket
  remote_state_region = var.aws_region

  terraform_state_key_prefixes = [
    "environments/${var.environment}/network/",
    "environments/${var.environment}/data/",
    "environments/${var.environment}/api-service/",
    "environments/${var.environment}/front-edge/",
    "environments/${var.environment}/async-worker/",
    "environments/${var.environment}/ops/",
    "environments/${var.environment}/ops/cicd/"
  ]
}

locals {
  ecr_repository_arns = data.terraform_remote_state.ops.outputs.ecr_repository_arns

  cluster_name = data.terraform_remote_state.api_service.outputs.cluster_name
}