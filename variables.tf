variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with Zone:Edit and DNS:Edit permissions"
  sensitive   = true
}
