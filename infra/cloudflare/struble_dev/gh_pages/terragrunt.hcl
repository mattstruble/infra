include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

inputs = {
  gh_pages_url = "mattstruble.github.io"
}

terraform {
  source = "../../../../modules/cloudflare/gh_pages"
}
