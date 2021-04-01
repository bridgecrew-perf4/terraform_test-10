module "security_group" {
    source = "../../modules/security_group"
}

module "iam_role" {
    source = "../../modules/iam_role"
}

output "role_cloudwatch" {
    value = module.iam_role.role_cloudwatch.name
}

output "sg_private" {
    value = module.security_group.sg_private.id
}