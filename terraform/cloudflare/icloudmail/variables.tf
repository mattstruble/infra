variable "cloudflare_zone_name" {
  description = "The name of the zone within Cloudflare"
  type        = string
}

variable "icloudmail_spf" {
  description = "The spf redirect for icloud"
  type        = string
  default     = "v=spf1 include:icloud.com ~all"
}

variable "icloudmail_verification" {
  description = "The icloud verification blob"
  type        = string
}

variable "icloudmail_mx_1" {
  description = "The first icloud MX redirect"
  type        = string
  default     = "mx01.mail.icloud.com"
}

variable "icloudmail_mx_2" {
  description = "The second icloud MX redirect"
  type        = string
  default     = "mx02.mail.icloud.com"
}

variable "icloudmail_dkim_1" {
  description = "The first protonmail dkim validation"
  type        = string
}


variable "icloudmail_dmarc" {
  description = "The protonmail dmarc configuration"
  type        = string
  default     = "v=DMARC1; p=quarantine;"
}
