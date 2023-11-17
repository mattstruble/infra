locals {
  stage = replace(basename(get_terragrunt_dir()), "_", "")
}
