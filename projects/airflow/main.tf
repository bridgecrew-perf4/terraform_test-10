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
    security_group_id = dependency.outputs.role_cloudwatch
    iam_role = dependency.outputs.sg_private
}
