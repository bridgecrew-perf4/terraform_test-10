data "aws_iam_policy" "power_user_policy" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

data "aws_iam_policy" "change_password_policy" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

module "pass_role_policy" {
  source = "./modules/iam/policy"
  name = "pass_role_policy"
  policy = file("iam_policies/pass_role_policy.json")
}

output "pass_role_policy" {
  value = module.pass_role_policy.policy_id
}

module "force_mfa_policy" {
  source = "./modules/iam/policy"
  name = "force_mfa_policy"
  policy = file("iam_policies/force_mfa_policy.json")
}

output "force_mfa_policy" {
  value = module.force_mfa_policy.policy_id
}