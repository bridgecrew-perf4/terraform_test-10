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
    security_group_id = data.terraform_remote_state.common.security_group.id
    iam_role = data.terraform_remote_state.common.security_group.id.name
}

data "terraform_remote_state" "common" {
    backend = "s3"

    config {
        bucket = "valis-develop"
        key = "common.tfstate"
        region = "ap-northeast-1"
    }
}
