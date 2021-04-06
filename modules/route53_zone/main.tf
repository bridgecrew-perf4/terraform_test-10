resource "aws_route53_zone" "private" {
    name = "valis.com"

    vpc {
        vpc_id = "vpc-a5dcbbc0"
    }
}