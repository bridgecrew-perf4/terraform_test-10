variable iam_users {}
variable pgp_key {}
variable iam_group_name {}
variable iam_group_membership_name {}

data "aws_iam_policy" "power_user_policy" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

data "aws_iam_policy" "change_password_policy" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

resource "aws_iam_policy" "pass_role_policy" {
  name   = "pass_role_policy"
  path   = "/"
  policy = file("./iam_policies/pass_role_policy.json")
}

resource "aws_iam_policy" "force_mfa_policy" {
  name   = "force_mfa_policy"
  path   = "/"
  policy = file("./iam_policies/force_mfa_policy.json")
}

resource "aws_iam_user" "iam_user" {
  count         = length(var.iam_users)
  name          = element(var.iam_users, count.index)
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "login_profile" {
  count                   = length(var.iam_users)
  user                    = element(var.iam_users, count.index)
  pgp_key                 = var.pgp_key
  password_reset_required = true
  password_length         = "20"
  depends_on = [aws_iam_user.iam_user]
}

output "user" {
  value = join("\n", aws_iam_user.iam_user.*.name)
}

output "password" {
  value = join("\n", aws_iam_user_login_profile.login_profile.*.encrypted_password)
}

resource "aws_iam_group" "iam_group" {
  name = var.iam_group_name
}

resource "aws_iam_group_membership" "iam_group_membership" {
  count = length(var.iam_users)
  name  = var.iam_group_membership_name
  users = [
    "${element(var.iam_users, count.index)}",
  ]
  group = aws_iam_group.iam_group.name
  depends_on = [aws_iam_user.iam_user]
}

resource "aws_iam_group_policy_attachment" "policy_attach" {
  group = aws_iam_group.iam_group.name
  for_each = toset([
    data.aws_iam_policy.power_user_policy.arn,
    data.aws_iam_policy.change_password_policy.arn,
    aws_iam_policy.force_mfa_policy.arn,
    aws_iam_policy.pass_role_policy.arn,
  ])
  policy_arn = each.value
  depends_on = [
      aws_iam_policy.force_mfa_policy,
      aws_iam_policy.pass_role_policy
  ]
}