module "kms_label" {
  source = "git::https://github.com/cloudposse/terraform-null-label.git?ref=main"

  context = var.label_context
}

resource "aws_kms_key" "kms_key" {
  description             = module.kms_label.id
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/${module.kms_label.id}"
  target_key_id = aws_kms_key.kms_key.key_id
}
