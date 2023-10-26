include {
  path = find_in_parent_folders()
}

inputs = {
    gh_pages_url = "mattstruble.github.io"
}

terraform {
    source = "../../../../modules/cloudflare/gh_pages"
}
