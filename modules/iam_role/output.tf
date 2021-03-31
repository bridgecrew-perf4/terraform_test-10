output "cloudwatch_role" {
    value = aws_iam_role.cloudwatch_test_role.name
}