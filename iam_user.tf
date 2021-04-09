variable iam_users {}
variable pgp_key {}

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
}

output "user" {
  value = join("\n", aws_iam_user.iam_user.*.name)
}

output "password" {
  value = join("\n", aws_iam_user_login_profile.login_profile.*.encrypted_password)
}
