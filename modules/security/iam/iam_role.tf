data "aws_iam_policy_document" "policy1" {
    statement {
        actions = []
        resources = []
    }
}

resource "aws_iam_policy" "policy1" {
    name        = "poricy1"
    path        = ""
    description = ""
    policy      = data.aws_iam_policy_document.policy1.json
}

resource "aws_iam_role" "name" {
    name = ""
}