module "instance" {
    source = "../../modules/ec2/private"
    name = "trader_tuner"
    instance_type = "t3.micro"
    security_group_id = data.terraform_remote_state.base.outputs.role_cloudwatch
    iam_role = data.terraform_remote_state.base.outputs.sg_private
}