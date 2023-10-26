output "cloudflare_struble_dev_zone_id" {
  value = data.cloudflare_zone.struble_dev.id
}

output "struble_dev_dns_servers" {
  value = data.cloudflare_zone.struble_dev.name_servers
}

output "struble_app_dns_servers" {
  value = data.cloudflare_zone.struble_app.name_servers
}
