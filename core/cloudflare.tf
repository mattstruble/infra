resource "cloudflare_zone" "struble_dev" {
  account_id = var.cloudflare_account_id
  zone       = "struble.dev"
}

# Email SPF

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "struble.dev"
  type    = "TXT"
  value   = "v=spf1 include:_spf.protonmail.ch mx ~all"
  ttl     = 86400
}

# ProtonMail

resource "cloudflare_record" "protonmail_verification" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "struble.dev"
  type    = "TXT"
  value   = "protonmail-verification=3af6a5bd38e303153ff1f47e1ae84348550bf101"
  ttl     = 86400
}

resource "cloudflare_record" "protonmail_mx_1" {
  zone_id  = cloudflare_zone.struble_dev.id
  name     = "struble.dev"
  type     = "MX"
  value    = "mail.protonmail.ch"
  ttl      = 86400
  priority = 10
}

resource "cloudflare_record" "protonmail_mx_2" {
  zone_id  = cloudflare_zone.struble_dev.id
  name     = "struble.dev"
  type     = "MX"
  value    = "mailsec.protonmail.ch"
  ttl      = 86400
  priority = 20
}

resource "cloudflare_record" "protonmail_dkim_1" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  value   = "protonmail.domainkey.dvu4n6x4rnptaek2rn6z223udeggcwpdxrtgeff4bxprwptwjxvda.domains.proton.ch."
  ttl     = 86400
  proxied = false
}

resource "cloudflare_record" "protonmail_dkim_2" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "protonmail2._domainkey"
  type    = "CNAME"
  value   = "protonmail2.domainkey.dvu4n6x4rnptaek2rn6z223udeggcwpdxrtgeff4bxprwptwjxvda.domains.proton.ch."
  ttl     = 86400
  proxied = false
}

resource "cloudflare_record" "protonmail_dkim_3" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "protonmail3._domainkey"
  type    = "CNAME"
  value   = "protonmail3.domainkey.dvu4n6x4rnptaek2rn6z223udeggcwpdxrtgeff4bxprwptwjxvda.domains.proton.ch."
  ttl     = 86400
  proxied = false
}

resource "cloudflare_record" "protonmail_dmarc" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=quarantine; rua=mailto:dmarc@struble.dev;"
  ttl     = 86400
}

# Bluesky

resource "cloudflare_record" "bluesky_proto" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "_atproto"
  type    = "TXT"
  value   = "did=did:plc:67hke6ig26o3huavs7mggdg2"
}

# GitHub Pages

resource "cloudflare_record" "gh_pages_apex" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "struble.dev"
  type    = "CNAME"
  value   = "mattstruble.github.io"
  proxied = true
}

resource "cloudflare_record" "gh_pages_www" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "www"
  type    = "CNAME"
  value   = "mattstruble.github.io"
  proxied = true
}

resource "cloudflare_page_rule" "gh_pages_rule_forward_www_to_apex" {
  zone_id  = cloudflare_zone.struble_dev.id
  target   = "https://www.struble.dev/"
  priority = 2

  actions {
    forwarding_url {
      url         = "https://struble.dev/"
      status_code = 301
    }
  }
}

resource "cloudflare_page_rule" "gh_pages_rule_cache_everything" {
  zone_id  = cloudflare_zone.struble_dev.id
  target   = "https://struble.dev/*"
  priority = 1

  actions {
    cache_level = "cache_everything"
  }
}

# Google Search Console

resource "cloudflare_record" "google_search_console_verification" {
  zone_id = cloudflare_zone.struble_dev.id
  name    = "struble.dev"
  type    = "TXT"
  value   = "google-site-verification=rKLUGfAqMz12e1zb1-E1wSPwBUu_UU3tE25oCm5BaZQ"
  ttl     = 86400
}

# Self-hosted apps

resource "cloudflare_zone" "struble_app" {
  account_id = var.cloudflare_account_id
  zone       = "struble.app"
}

resource "cloudflare_record" "apps_cname" {
  zone_id = cloudflare_zone.struble_app.id
  name    = "*"
  type    = "CNAME"
  value   = "struble.app"
  proxied = true
}

resource "cloudflare_record" "apps_caa" {
  zone_id = cloudflare_zone.struble_app.id
  name    = "struble.app"
  type    = "CAA"
  ttl     = 86400

  data {
    flags = "0"
    tag   = "issuewild"
    value = "letsencrypt.org"
  }
}
