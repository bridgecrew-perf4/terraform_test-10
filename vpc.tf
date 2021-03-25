resource "aws_vpc" "valis_staging" {
  cidr_block                       = "10.110.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name = "valis-staging"
  }
}