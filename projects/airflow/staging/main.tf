locals {
  name = "trader_airflow_staging"
}

module "instance" {
    source = "../../../modules/instance"
    name = local.name
    instance_type = "t3.micro"
    security_group_id = data.terraform_remote_state.base.outputs.sg_private
    iam_role = data.terraform_remote_state.base.outputs.role_cloudwatch
}

module "route53" {
    source = "../../../modules/route53"
    name = local.name
}

module "cloud_watch" {
    source = "../../../modules/cloud_watch"
    name = local.name
}