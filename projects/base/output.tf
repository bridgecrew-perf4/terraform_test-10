output "role_cloudwatch" {
    value = module.iam_role.role_cloudwatch.name
}

output "sg_private" {
    value = module.security_group.sg_private.id
}

output "route53_zone" {
    value = module.route53_zone.route53_zone.zone_id
}