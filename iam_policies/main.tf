resource "aws_iam_policy" "pass_role_policy" {
  name   = "pass_role_policy"
  path   = "/"
  policy = file("./json/pass_role_policy.json")
}

resource "aws_iam_policy" "force_mfa_policy" {
  name   = "force_mfa_policy"
  path   = "/"
  policy = file("./json/force_mfa_policy.json")
}

output "pass_role_policy_arn" {
  value = aws_iam_policy.pass_role_policy.arn
}

output "force_mfa_policy_arn" {
  value = aws_iam_policy.force_mfa_policy.arn
}
