variable "cloudflare_zone_name" {
  description = "The name of the zone within Cloudflare"
  type        = string
}

variable "txt_record_value" {
  description = "The txt record value"
  type        = string
}
variable "txt_record_name" {
  description = "The txt record name"
  type        = string
  default     = "@"
}
