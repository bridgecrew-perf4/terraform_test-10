resource "aws_internet_gateway" "valis_staging" {
  vpc_id = aws_vpc.valis_staging.id
  tags = {
    Name = "valis-staging"
  }
}

resource "aws_route_table" "valis_staging" {
  vpc_id = aws_vpc.valis_staging.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.valis_staging.id
  }

  tags = {
    Name = "valis-staging"
  }
}

resource "aws_route_table" "trader_private" {
  vpc_id = aws_vpc.valis_staging.id
  route {
    nat_gateway_id = aws_nat_gateway.trader_nat.id
    cidr_block     = "0.0.0.0/0"
  }
  tags = {
    Name = "trader_private"
  }
}

resource "aws_eip" "trader_nat" {
  vpc = true
  tags = {
    Name = "trader_nat"
  }
}

resource "aws_nat_gateway" "trader_nat" {
  subnet_id     = aws_subnet.trader_public.id
  allocation_id = aws_eip.trader_nat.id
  tags = {
    Name = "trader_nat_gateway"
  }
}

resource "aws_route_table_association" "trader_public" {
  subnet_id      = aws_subnet.trader_public.id
  route_table_id = aws_route_table.valis_staging.id
}

resource "aws_route_table_association" "trader_private" {
  subnet_id      = aws_subnet.trader_private.id
  route_table_id = aws_route_table.trader_private.id
}