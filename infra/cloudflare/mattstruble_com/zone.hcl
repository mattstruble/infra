locals {
  zone_name = replace(basename(get_terragrunt_dir()), "_", ".")
}
