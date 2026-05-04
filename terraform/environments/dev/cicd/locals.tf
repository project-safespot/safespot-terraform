locals {
  remote_state_bucket = var.terraform_state_bucket
  remote_state_region = var.aws_region

  terraform_state_key_prefixes = [
    "${var.env}/ops",
    "${var.env}/cicd",
    "${var.env}/network",
    "${var.env}/data",
    "${var.env}/api-service",
    "${var.env}/async-worker",
    "${var.env}/front-edge",
    "${var.env}/application"
  ]
}