output "role_cloudwatch" {
    value = module.aws_iam_role.role_cloudwatch.name
}

output "sg_private" {
    value = module.aws_security_group.sg_private.id
}