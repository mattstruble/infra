module "iam_label" {
  source = "git::https://github.com/cloudposse/terraform-null-label.git?ref=main"

  context = var.label_context
}

resource "aws_iam_user" "iam_user" {
  name = module.iam_label.id
}

resource "aws_iam_user_policy_attachment" "admin_policy" {
  user       = aws_iam_user.iam_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
