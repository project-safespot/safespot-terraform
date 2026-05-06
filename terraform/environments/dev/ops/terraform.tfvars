aws_region          = "ap-northeast-2"
environment         = "dev"
project             = "safespot"
remote_state_bucket = "safespot-terraform-state"
remote_state_region = "ap-northeast-2"

services = [
  "api-core",
  "api-public-read",
  "external-ingestion",
]

log_retention_days = 30

enable_observability_iam = true
enable_fluentbit_irsa    = true
enable_prometheus_irsa   = true
enable_grafana_irsa      = true