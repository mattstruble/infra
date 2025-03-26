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

# Email SPF

resource "cloudflare_record" "spf" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "TXT"
  value   = var.icloudmail_spf
}

# ProtonMail

resource "cloudflare_record" "verification" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "TXT"
  value   = var.icloudmail_verification
}

resource "cloudflare_record" "mx_1" {
  zone_id  = data.cloudflare_zone.zone_data.id
  name     = var.cloudflare_zone_name
  type     = "MX"
  value    = var.icloudmail_mx_1
  priority = 10
}

resource "cloudflare_record" "mx_2" {
  zone_id  = data.cloudflare_zone.zone_data.id
  name     = var.cloudflare_zone_name
  type     = "MX"
  value    = var.icloudmail_mx_2
  priority = 20
}

resource "cloudflare_record" "dkim_1" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  value   = var.icloudmail_dkim_1
  proxied = false
}

resource "cloudflare_record" "protonmail_dmarc" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "_dmarc"
  type    = "TXT"
  value   = var.icloudmail_dmarc
}
