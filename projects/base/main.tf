module "security_group" {
    source = "../../modules/security_group"
}

module "iam_role" {
    source = "../../modules/iam_role"
}

module "route53_zone" {
    source = "../../modules/route53_zone"
}