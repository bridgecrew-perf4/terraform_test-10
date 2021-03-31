resource "aws_security_group" "trader_private" {
  name        = "trader_private"
  vpc_id      = "vpc-a5dcbbc0"
  description = "private security"
  tags = {
    Name = "trader-private"
  }
}

resource "aws_security_group_rule" "trader_private_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  description       = "trader-staging vpc only"
  protocol          = "tcp"
  cidr_blocks       = ["10.110.0.0/16"]
  security_group_id = aws_security_group.trader_private.id
}

resource "aws_security_group_rule" "trader_private_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.trader_private.id
}

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

resource "aws_instance" "instance" {
  count                  = 1
  ami                    = "ami-09d28faae2e9e7138"
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_role.cloudwatch_test_role.name
  key_name               = "baba-test"
  subnet_id              = "subnet-0872ffa27ce8a2735"
  vpc_security_group_ids = [aws_security_group.trader_private.id]
  tags = {
    Name = var.name
  }
}
