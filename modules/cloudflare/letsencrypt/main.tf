terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.1"
    }
  }
}
data "cloudflare_zone" "zone_data" {
  name = var.cloudflare_zone_name
}

resource "cloudflare_record" "wildcard_cname" {
  allow_overwrite = true
  zone_id         = data.cloudflare_zone.zone_data.id
  name            = "*"
  type            = "CNAME"
  value           = var.cloudflare_zone_name
  proxied         = true
}

resource "cloudflare_record" "wildcard_letsencrypt_caa" {
  allow_overwrite = true
  zone_id         = data.cloudflare_zone.zone_data.id
  name            = var.cloudflare_zone_name
  type            = "CAA"
  ttl             = 86400

  data {
    flags = "0"
    tag   = "issuewild"
    value = "letsencrypt.org"
  }
}
