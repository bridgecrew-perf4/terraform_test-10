locals {
  config = yamldecode(file("../config.yml"))
}

data "aws_iam_policy" "power_user_policy" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

data "aws_iam_policy" "change_password_policy" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

data "terraform_remote_state" "iam_policy" {
  backend = "s3"
  config = {
    bucket = local.config.bucket
    key = "${local.config.key_prefix}/iam_policies/terraform.tfstate"
    region = local.config.region
  }
}

resource "aws_iam_user" "iam_user" {
  count         = length(local.config.iam_users)
  name          = element(local.config.iam_users, count.index)
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "login_profile" {
  count                   = length(local.config.iam_users)
  user                    = element(local.config.iam_users, count.index)
  pgp_key                 = local.config.pgp_key
  password_reset_required = true
  password_length         = "20"
  depends_on = [aws_iam_user.iam_user]
}

resource "aws_iam_group" "iam_group" {
  name = local.config.iam_group_name
}

resource "aws_iam_group_membership" "iam_group_membership" {
  count = length(local.config.iam_users)
  name  = local.config.iam_group_membership_name
  users = [
    "${element(local.config.iam_users, count.index)}",
  ]
  group = aws_iam_group.iam_group.name
  depends_on = [aws_iam_user.iam_user]
}

resource "aws_iam_group_policy_attachment" "policy_attach" {
  group = aws_iam_group.iam_group.name
  for_each = toset([
    data.aws_iam_policy.power_user_policy.arn,
    data.aws_iam_policy.change_password_policy.arn,
    data.terraform_remote_state.iam_policy.outputs.pass_role_policy_arn,
    data.terraform_remote_state.iam_policy.outputs.force_mfa_policy_arn
  ])
  policy_arn = each.value
}

output "user" {
  value = "${join("\n", aws_iam_user.iam_user.*.name)}"
}

output "password" {
  value = "${join("\n", aws_iam_user_login_profile.login_profile.*.encrypted_password)}"
}
