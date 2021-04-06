resource "aws_route53_record" "this" {
    name = var.name
    ttl  = var.ttl
    type = var.type
    zone_id = var.zone_id
}