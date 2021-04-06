resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${var.name}_memory_alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  alarm_actions       = ["arn:aws:sns:ap-northeast-1:306374182646:trader_test_alert"]
  datapoints_to_alarm = 1
  dimensions = {
    "host" = var.name
  }
  metric_name = "mem_used_percent"
  period      = "60"
  namespace   = "CWAgent"
  statistic   = "Maximum"
  threshold   = 20
}