output "cloudwatch_role" {
    value = aws_iam_role.cloudwatch_test_role.name
}

output "trader_private_security_group_id" {
    value = aws_security_group.trader_private.id
}