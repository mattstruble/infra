terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

data "cloudflare_zone" "zone_data" {
  name = var.cloudflare_zone_name
}

resource "cloudflare_record" "wildcard_cname" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "*"
  type    = "CNAME"
  value   = var.cloudflare_zone_name
  proxied = true
}

resource "cloudflare_record" "wildcard_letsencrypt_caa" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "CAA"

  data {
    flags = "0"
    tag   = "issuewild"
    value = "letsencrypt.org"
  }
}
