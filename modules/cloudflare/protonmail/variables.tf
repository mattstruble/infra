variable "cloudflare_zone_name" {
  description = "The name of the zone within Cloudflare"
  type        = string
}

variable "protonmail_spf" {
  description = "The spf redirect for protonmail"
  type        = string
}

variable "protonmail_verification" {
  description = "The protonmail verification blob"
  type        = string
}

variable "protonmail_mx_1" {
  description = "The first protonmail MX redirect"
  type        = string
}

variable "protonmail_mx_2" {
  description = "The second protonmail MX redirect"
  type        = string
}

variable "protonmail_dkim_1" {
  description = "The first protonmail dkim validation"
  type        = string
}

variable "protonmail_dkim_2" {
  description = "The second protonmail dkim validation"
  type        = string
}

variable "protonmail_dkim_3" {
  description = "The second protonmail dkim validation"
  type        = string
}

variable "protonmail_dmarc" {
  description = "The protonmail dmarc configuration"
  type        = string
}
