resource "aws_subnet" "trader_public" {
  vpc_id                  = aws_vpc.valis_staging.id
  cidr_block              = "10.110.40.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "trader_public"
  }
}

resource "aws_subnet" "trader_private" {
  vpc_id                  = aws_vpc.valis_staging.id
  cidr_block              = "10.110.50.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "trader_private"
  }
}