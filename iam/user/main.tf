resource "aws_iam_user" "iam_user" {
  count         = 1
  name          = element(var.iam_users, count.index)
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "login_profile" {
  count                   = 1
  user                    = element(var.iam_users, count.index)
  pgp_key                 = "keybase:exp_example"
  password_reset_required = true
  password_length         = "20"
}

output "user" {
  value = join("\n", aws_iam_user.iam_user.*.name)
}

output "password" {
  value = join("\n", aws_iam_user_login_profile.login_profile.encrypted_password)
}
