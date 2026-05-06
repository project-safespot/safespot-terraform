# modules/ops/cloudwatch/metric-alarms-edge.tf
#
# CloudFront, WAF metric은 us-east-1에서만 수집된다.
# provider = aws.us_east_1 필수.

resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx" {
  provider = aws.us_east_1
  count    = local.has_cloudfront ? 1 : 0

  alarm_name          = "${local.name_prefix}-cloudfront-5xx-rate"
  alarm_description   = "CloudFront 5xx 오류율 임계값 초과"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = var.cloudfront_5xx_threshold
  treat_missing_data  = "notBreaching"

  dimensions = {
    DistributionId = var.cloudfront_distribution_id
    Region         = "Global"
  }

  alarm_actions = []
  ok_actions    = []
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_4xx" {
  provider = aws.us_east_1
  count    = local.has_cloudfront ? 1 : 0

  alarm_name          = "${local.name_prefix}-cloudfront-4xx-rate"
  alarm_description   = "CloudFront 4xx 오류율 임계값 초과"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = var.cloudfront_4xx_threshold
  treat_missing_data  = "notBreaching"

  dimensions = {
    DistributionId = var.cloudfront_distribution_id
    Region         = "Global"
  }

  alarm_actions = []
  ok_actions    = []
}

resource "aws_cloudwatch_metric_alarm" "waf_blocked_requests" {
  provider = aws.us_east_1
  count    = local.has_waf ? 1 : 0

  alarm_name          = "${local.name_prefix}-waf-blocked-requests"
  alarm_description   = "WAF BlockedRequests 임계값 초과"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "BlockedRequests"
  namespace           = "AWS/WAFV2"
  period              = 60
  statistic           = "Sum"
  threshold           = var.waf_blocked_threshold
  treat_missing_data  = "notBreaching"

  # WAFV2 CloudFront용 dimension:
  # WebACL: WAF ACL 이름
  # Rule: 규칙 이름 ("ALL" = 전체 합산)
  # Region: CloudFront WAF는 반드시 "CloudFront" (콘솔에서는 "Global"로 표시되지만
  #         CloudWatch metric dimension 값은 "CloudFront"를 사용해야 한다)
  dimensions = {
    WebACL = var.waf_acl_name
    Rule   = "ALL"
    Region = "CloudFront"
  }

  alarm_actions = []
  ok_actions    = []
}
