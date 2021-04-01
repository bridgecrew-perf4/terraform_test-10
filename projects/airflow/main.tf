terraform {
    required_version = "~> 0.14"
    backend "s3" {}
}

provider "aws" {
    region = "ap-northeast-1"
}

data "terraform_remote_state" "base" {
    backend = "s3"

    config = {
        bucket = "valis-develop"
        key = "terraform/base.tfstate"
        region = "ap-northeast-1"
    }
}

module "instance" {
    source = "../../modules/instance"
    name = "trader_airflow"
    instance_type = "t3.micro"
    security_group_id = data.terraform_remote_state.base.outputs.role_cloudwatch.value
    iam_role = data.terraform_remote_state.base.outputs.sg_private.value
}
