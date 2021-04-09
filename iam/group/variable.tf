variable "iam_group_name" {
  type        = string
  description = "IAM Group名"
}

variable "iam_group_membership_name" {
  type        = string
  description = "IAM Group Membership名"
}

variable "iam_users" {
  type        = list(any)
  description = "IAM Userリスト"
}

variable "group_policys" {
  type        = list(any)
  description = "IAM GroupにアタッチするPolicyリスト"
}
