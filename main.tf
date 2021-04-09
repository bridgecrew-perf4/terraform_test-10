provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = "~> 2.0"
  }
}

terraform {
  backend "s3" {
    bucket = "valis-develop"
    key    = "terraform/iam_user/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

module "iam_user" {
    source = "./modules/iam/user"
    iam_user_count = 2
    iam_users = [
        "test_user1",
        "test_user2"
    ]
}

module "iam_group" {
    source = "./modules/iam/group"
    count = 2
    iam_group_name = "test_group"
    iam_group_membership_name = "test_iam_group_membership"
    iam_users = [
        "test_user1",
        "test_user2"
    ]
    group_policys = [
        data.aws_iam_policy.power_user_policy.arn,
        data.aws_iam_policy.change_password_policy.arn,
        module.force_mfa_policy.policy_id,
        module.pass_role_policy.policy_id
    ]
}