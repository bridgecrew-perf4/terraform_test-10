resource "aws_iam_policy" "policy" {
  name   = var.name
  path   = "/"
  policy = jsonencode(var.policy)
}

output "policy_id" {
  value = aws_iam_policy.policy.id
}