locals {
  project     = "safespot"
  domain      = "ops"
  name_prefix = "${local.project}-${var.env}-${local.domain}"

  sns_topic_name = "${local.name_prefix}-sns-alert"

  slack_secret_name = (
    var.slack_webhook_secret_name != ""
    ? var.slack_webhook_secret_name
    : "safespot/${var.env}/alertmanager/slack-webhook"
  )

  all_email_subscriptions = concat(
    [var.alert_email],
    var.additional_email_subscriptions
  )
}