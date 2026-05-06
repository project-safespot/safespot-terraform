locals {
  domain      = "ops"
  name_prefix = "${var.project}-${var.environment}-${local.domain}"
}
