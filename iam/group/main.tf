resource "aws_iam_group_membership" "iam_group_membership" {
  count = 1
  name  = var.iam_group_membership_name
  users = [
    "${element(var.iam_users, count.index)}",
  ]
  group = var.iam_group_name
}

resource "aws_iam_group" "iam_group" {
  name = var.iam_group_name
}

resource "aws_iam_group_policy_attachment" "policy_attach" {
  group      = var.iam_group_name
  for_each   = toset(var.group_policys)
  policy_arn = each.value
}