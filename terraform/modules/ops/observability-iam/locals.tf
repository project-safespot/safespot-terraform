locals {
  name_prefix = "safespot-${var.environment}"

  fluentbit_log_group_arns = length(var.log_group_arns) > 0 ? var.log_group_arns : ["*"]
}
