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

# Email SPF

resource "cloudflare_record" "spf" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "TXT"
  value   = var.tutamail_spf
}

# ProtonMail

resource "cloudflare_record" "tutamail_verification" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "TXT"
  value   = var.tutamail_verification
}

resource "cloudflare_record" "tutamail_mx" {
  zone_id  = data.cloudflare_zone.zone_data.id
  name     = var.cloudflare_zone_name
  type     = "MX"
  value    = var.tutamail_mx
  priority = 10
}

resource "cloudflare_record" "tutamail_dkim_1" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "s1._domainkey"
  type    = "CNAME"
  value   = var.tutamail_dkim_1
  proxied = false
}

resource "cloudflare_record" "tutamail_dkim_2" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "s2._domainkey"
  type    = "CNAME"
  value   = var.tutamail_dkim_2
  proxied = false
}

resource "cloudflare_record" "tutamail_mta_1" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "_mta-sts"
  type    = "CNAME"
  value   = var.tutamail_mta
  proxied = false
}

resource "cloudflare_record" "tutamail_mta_2" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "mta-sts"
  type    = "CNAME"
  value   = var.tutamail_mta
  proxied = false
}

resource "cloudflare_record" "dmarc" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "_dmarc"
  type    = "TXT"
  value   = var.dmarc
}
