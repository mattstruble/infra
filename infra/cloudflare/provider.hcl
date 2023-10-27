locals {
  secrets   = yamldecode(file(find_in_parent_folders("secrets.yaml")))
  api_token = local.secrets.cloudflare_api_token

  zone_vars = read_terragrunt_config(find_in_parent_folders("zone.hcl"))
  zone_name = local.zone_vars.locals.zone_name
}

inputs = {
  cloudflare_zone_name = local.zone_name
}

generate "provider" {

  path      = "provider_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
    required_providers {
        cloudflare = {
            source = "cloudflare/cloudflare"
            version = "~> 4.1"
        }
    }
}

provider "cloudflare" {
    api_token = "${local.api_token}"
}
EOF
}
