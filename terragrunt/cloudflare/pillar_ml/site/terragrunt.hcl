include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

inputs = {
  records = [
    {
      name    = "@"
      value   = "pillar-ml.github.io"
      type    = "CNAME"
      proxied = true
      ttl     = 1
    },
    {
      name    = "www"
      value   = "pillar.ml"
      type    = "CNAME"
      proxied = true
      ttl     = 1
    },
    {
      name    = "*"
      value   = "pillar.ml"
      type    = "CNAME"
      proxied = true
      ttl     = 1
    }
  ]
}

terraform {
  source = "git::git@github.com:cloudposse/terraform-cloudflare-zone.git/?ref=v1.0.1"
}
