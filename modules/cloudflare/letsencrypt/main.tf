resource "cloudflare_zone" "zone_data" {
  zone = var.cloudflare_zone_name
}

resource "cloudflare_record" "wildcard_cname" {
  zone_id = cloudflare_zone.zone_data.id
  name    = "*"
  type    = "CNAME"
  value   = var.cloudflare_zone_name
  proxied = true
}

resource "cloudflare_record" "wildcard_letsencrypt_caa" {
  zone_id = cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "CAA"
  ttl     = 86400

  data {
    flags = "0"
    tag   = "issuewild"
    value = "letsencrypt.org"
  }
}
