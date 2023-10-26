inputs = {
  cloudflare_zone_name = replace(basename(get_terragrunt_dir()), "_", ".")
}
