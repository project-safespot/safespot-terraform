# modules/ops/cloudwatch/metric-alarms-alb.tf

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  count = local.has_alb ? 1 : 0

  alarm_name          = "${local.name_prefix}-alb-5xx"
  alarm_description   = "ALB 5xx 오류 발생"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = var.alb_5xx_threshold
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = local.alarm_actions
  ok_actions    = []
}

resource "aws_cloudwatch_metric_alarm" "alb_latency" {
  count = local.has_alb ? 1 : 0

  alarm_name          = "${local.name_prefix}-alb-latency"
  alarm_description   = "ALB TargetResponseTime p99 임계값 초과"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  extended_statistic  = "p99"
  threshold           = var.alb_latency_threshold
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = local.alarm_actions
  ok_actions    = []
}

resource "aws_cloudwatch_metric_alarm" "alb_4xx" {
  count = local.has_alb ? 1 : 0

  alarm_name          = "${local.name_prefix}-alb-4xx"
  alarm_description   = "ALB 4xx 오류 급증"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = var.alb_4xx_threshold
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = local.alarm_actions
  ok_actions    = []
}