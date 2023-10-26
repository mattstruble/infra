locals  {
  secrets   = yamldecode(file("${get_terragrunt_dir()}/secrets.yaml"))
  api_token = local.secrets.cloudflare_api_token
}


generate "provider" {
  path      = "cloudflare_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "cloudflare" {
    api_token = ${local.api_token}
}
EOF
}
