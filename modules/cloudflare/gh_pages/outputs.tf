output "cloudflare_zone_id" {
  value = data.cloudflare_zone.zone_data.id
}

output "cloudflare_zone_dns_servers" {
  value = data.cloudflare_zone.zone_data.name_servers
}
