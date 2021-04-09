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