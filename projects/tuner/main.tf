terraform {
    required_version = "~> 0.14"
    backend "s3" {}
}

provider "aws" {
    region = "ap-northeast-1"
}

module "instance" {
    source = "../../modules/ec2/private"
    name = "trader_tuner"
    instance_type = "t3.micro"
}