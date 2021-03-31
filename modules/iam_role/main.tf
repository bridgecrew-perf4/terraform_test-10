data "aws_iam_policy_document" "trader_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "cloudwatch_full_access" {
  arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

data "aws_iam_policy" "cloudwatchagent_admin" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

resource "aws_iam_role" "cloudwatch_test_role" {
  name               = "EC2CloudWatchTest"
  assume_role_policy = data.aws_iam_policy_document.trader_policy.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_test_role_cloudwatch_policy_attach" {
  role       = aws_iam_role.cloudwatch_test_role.name
  policy_arn = data.aws_iam_policy.cloudwatch_full_access.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_test_role_cloudwatchagent_policy_attach" {
  role       = aws_iam_role.cloudwatch_test_role.name
  policy_arn = data.aws_iam_policy.cloudwatchagent_admin.arn
}