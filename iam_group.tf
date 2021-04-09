variable iam_group_name {}
variable iam_group_membership_name {}
variable iam_users {}

resource "aws_iam_group" "iam_group" {
  name = var.iam_group_name
}

resource "aws_iam_group_membership" "iam_group_membership" {
  count = length(var.iam_users)
  name  = var.iam_group_membership_name
  users = [
    "${element(var.iam_users, count.index)}",
  ]
  group = var.iam_group_name
}

resource "aws_iam_group_policy_attachment" "policy_attach" {
  group = var.iam_group_name
  for_each = toset([
    data.aws_iam_policy.power_user_policy.arn,
    data.aws_iam_policy.change_password_policy.arn,
    aws_iam_policy.force_mfa_policy.arn,
    aws_iam_policy.pass_role_policy.arn
  ])
  policy_arn = each.value
}