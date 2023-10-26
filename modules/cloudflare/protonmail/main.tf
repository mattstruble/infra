resource "cloudflare_zone" "zone_data" {
  name = var.cloudflare_zone_name
}

# Email SPF

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "TXT"
  value   = var.protonmail_spf
  ttl     = 86400
}

# ProtonMail

resource "cloudflare_record" "protonmail_verification" {
  zone_id = cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "TXT"
  value   = var.protonmail_verification
  ttl     = 86400
}

resource "cloudflare_record" "protonmail_mx_1" {
  zone_id  = cloudflare_zone.zone_data.id
  name     = var.cloudflare_zone_name
  type     = "MX"
  value    = var.protonmail_mx_1
  ttl      = 86400
  priority = 10
}

resource "cloudflare_record" "protonmail_mx_2" {
  zone_id  = cloudflare_zone.zone_data.id
  name     = var.cloudflare_zone_name
  type     = "MX"
  value    = var.protonmail_mx_2
  ttl      = 86400
  priority = 20
}

resource "cloudflare_record" "protonmail_dkim_1" {
  zone_id = cloudflare_zone.zone_data.id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  value   = var.protonmail_dkim_1
  ttl     = 86400
  proxied = false
}

resource "cloudflare_record" "protonmail_dkim_2" {
  zone_id = cloudflare_zone.zone_data.id
  name    = "protonmail2._domainkey"
  type    = "CNAME"
  value   = var.protonmail_dkim_2
  ttl     = 86400
  proxied = false
}

resource "cloudflare_record" "protonmail_dkim_3" {
  zone_id = cloudflare_zone.zone_data.id
  name    = "protonmail3._domainkey"
  type    = "CNAME"
  value   = var.protonmail_dkim_3
  ttl     = 86400
  proxied = false
}

resource "cloudflare_record" "protonmail_dmarc" {
  zone_id = cloudflare_zone.zone_data.id
  name    = "_dmarc"
  type    = "TXT"
  value   = var.protonmail_dmarc
  ttl     = 86400
}
