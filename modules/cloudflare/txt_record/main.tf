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

resource "cloudflare_record" "spf" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "TXT"
  value   = var.txt_record_value
}
