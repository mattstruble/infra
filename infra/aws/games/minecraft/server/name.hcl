locals {
  name = replace(basename(get_terragrunt_dir()), "_", "")
}
