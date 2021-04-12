resource "aws_iam_user" "iam_user" {
  count         = 2
  name          = element(["test_user_a", "test_user_b"], count.index)
  path          = "/"
  force_destroy = true
}