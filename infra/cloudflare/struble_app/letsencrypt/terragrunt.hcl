include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

terraform {
    source = "../../../../modules/cloudflare/letsencrypt"
}
