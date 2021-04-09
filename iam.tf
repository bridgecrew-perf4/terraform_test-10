data "aws_iam_policy" "power_user_policy" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

data "aws_iam_policy" "change_password_policy" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

data "template_file" "pass_role_policy_template" {
  template = file("./iam_policies/pass_role_policy.json")
}

data "template_file" "force_mfa_policy_template" {
  template = file("./iam_policies/force_mfa_policy.json")
}

module "pass_role_policy" {
  source = "./modules/iam/policy"
  name = "pass_role_policy"
  policy = data.template_file.pass_role_policy_template.rendered
}

output "pass_role_policy" {
  value = module.pass_role_policy.policy_id
}

module "force_mfa_policy" {
  source = "./modules/iam/policy"
  name = "force_mfa_policy"
  policy = data.template_file.force_mfa_policy_template.rendered
}

output "force_mfa_policy" {
  value = module.force_mfa_policy.policy_id
}