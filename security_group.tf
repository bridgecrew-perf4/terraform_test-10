resource "aws_security_group" "dproxy" {
  name        = "dproxy"
  vpc_id      = aws_vpc.valis_staging.id
  description = "access via dproxy"
  tags = {
    Name = "dproxy"
  }
}

resource "aws_security_group_rule" "dproxy_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["52.68.192.112/32"]
  security_group_id = aws_security_group.dproxy.id
}

resource "aws_security_group_rule" "dproxy_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dproxy.id
}

resource "aws_security_group" "trader_private" {
  name        = "trader_private"
  vpc_id      = aws_vpc.valis_staging.id
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
