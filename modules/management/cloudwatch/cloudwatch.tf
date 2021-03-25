resource "aws_cloudwatch_metric_alarm" "trader_public_memory_alert" {
  alarm_name          = "trader_public_memory_alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  alarm_actions       = ["arn:aws:sns:ap-northeast-1:306374182646:trader_test_alert"]
  datapoints_to_alarm = 1
  dimensions = {
    "host" = "ip-10-110-40-120"
  }
  metric_name = "mem_used_percent"
  period      = "60"
  namespace   = "CWAgent"
  statistic   = "Maximum"
  threshold   = 20
}

resource "aws_cloudwatch_metric_alarm" "trader_private_memory_alert" {
  alarm_name          = "trader_private_memory_alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  alarm_actions       = ["arn:aws:sns:ap-northeast-1:306374182646:trader_test_alert"]
  datapoints_to_alarm = 1
  dimensions = {
    "host" = "ip-10-110-50-17"
  }
  metric_name = "mem_used_percent"
  period      = "60"
  namespace   = "CWAgent"
  statistic   = "Maximum"
  threshold   = 20
}