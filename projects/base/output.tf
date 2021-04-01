output "role_cloudwatch" {
    value = module.aws_iam_role.cloudwatch_test_role.name
}

output "sg_private" {
    value = module.aws_security_group.trader_private.id
}