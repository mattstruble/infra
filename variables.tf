variable "cloudflare_account_id" {
  type        = string
  description = "Account ID to manage the zone resource in."
  sensitive   = true
}

variable "cloudflare_api_token" {
  type        = string
  description = "API token to access cloudflare with"
  sensitive   = true
}
