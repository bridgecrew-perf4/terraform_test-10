resource "aws_instance" "trader_public" {
  count                  = 1
  ami                    = "ami-09d28faae2e9e7138"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_role.cloudwatch_test_role.name
  private_ip             = "10.110.40.120"
  key_name               = "baba-test"
  subnet_id              = aws_subnet.trader_public.id
  vpc_security_group_ids = [aws_security_group.dproxy.id]
  tags = {
    Name = "trader_public"
  }
}

resource "aws_instance" "trader_private" {
  count                  = 1
  ami                    = "ami-09d28faae2e9e7138"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_role.cloudwatch_test_role.name
  private_ip             = "10.110.50.17"
  key_name               = "baba-test"
  subnet_id              = aws_subnet.trader_private.id
  vpc_security_group_ids = [aws_security_group.trader_private.id]
  tags = {
    Name = "trader_private"
  }
}