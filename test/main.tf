resource "aws_iam_user" "iam_user" {
  count         = 2
  name          = element(["test_user_a", "test_user_b"], count.index)
  path          = "/"
  force_destroy = true
}

resource "aws_iam_group" "iam_group" {
  name = "test_grouppppp"
}

resource "aws_iam_group_membership" "iam_group_membership" {
  count = length(aws_iam_user.iam_user.*.name)
  name  = "test_groupppp_memebership"
  users = aws_iam_user.iam_user.*.name
  group = aws_iam_group.iam_group.name
}

output "users" {
  value = aws_iam_user.iam_user.*.name
}