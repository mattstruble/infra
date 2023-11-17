include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

inputs = {
  gh_pages_url = "struble.dev"
}

terraform {
  source = "../../../../terraform/cloudflare/gh_pages"
}
