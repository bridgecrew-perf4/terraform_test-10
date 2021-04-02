module "instance" {
    source = "../../../modules/instance"
    name = "tuner_staging"
    instance_type = "t3.micro"
    security_group_id = data.terraform_remote_state.base.outputs.sg_private
    iam_role = data.terraform_remote_state.base.outputs.role_cloudwatch
}
