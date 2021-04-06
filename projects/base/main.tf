module "security_group" {
    source = "../../modules/security_group"
}

module "iam_role" {
    source = "../../modules/iam_role"
}

module "route53_zone" {
    source = "../../modules/route53_zone"
}

output "role_cloudwatch" {
    value = module.iam_role.role_cloudwatch.name
}

output "sg_private" {
    value = module.security_group.sg_private.id
}

output "route53_zone" {
    value = module.route53_zone.private.zone_id
}