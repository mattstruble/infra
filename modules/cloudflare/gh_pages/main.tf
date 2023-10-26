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

resource "cloudflare_record" "pages_apex" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = var.cloudflare_zone_name
  type    = "CNAME"
  value   = var.gh_pages_url
  proxied = true
}

resource "cloudflare_record" "pages_www" {
  zone_id = data.cloudflare_zone.zone_data.id
  name    = "www"
  type    = "CNAME"
  value   = var.gh_pages_url
  proxied = true
}

resource "cloudflare_page_rule" "pages_rule_forward_www_to_apex" {
  zone_id  = data.cloudflare_zone.zone_data.id
  target   = "https://www.${var.cloudflare_zone_name}/"
  priority = 2

  actions {
    forwarding_url {
      url         = "https://${var.cloudflare_zone_name}/"
      status_code = 301
    }
  }
}

resource "cloudflare_page_rule" "pages_rule_cache_everything" {
  zone_id  = data.cloudflare_zone.zone_data.id
  target   = "https://${var.cloudflare_zone_name}/*"
  priority = 1

  actions {
    cache_level = "cache_everything"
  }
}
