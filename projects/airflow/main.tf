terraform {
    required_version = "~> 0.14"
    backend "s3" {}
}

provider "aws" {
    region = "ap-northeast-1"
}

module "instance" {
    source = "../../modules/instance"
    name = "trader_airflow"
    instance_type = "t3.micro"
    security_group_id = module.security_group.trader_private_security_group_id
    iam_role = module.iam_role.cloudwatch_role
}