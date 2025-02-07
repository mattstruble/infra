locals {
  namespace = replace(basename(get_terragrunt_dir()), "_", "")
}
