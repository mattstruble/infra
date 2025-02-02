variable "cloudflare_zone_name" {
  description = "The name of the zone within Cloudflare"
  type        = string
}

variable "tutamail_spf" {
  description = "The spf redirect for tutamail"
  type        = string
  default     = "v=spf1 include:spf.tutanota.de -all"
}

variable "tutamail_verification" {
  description = "The tutamail verification blob"
  type        = string
}

variable "tutamail_mx" {
  description = "The tutamail MX redirect"
  type        = string
  default     = "mail.tutanota.de"
}

variable "tutamail_dkim_1" {
  description = "The first tutamail dkim validation"
  type        = string
  default     = "s1.domainkey.tutanota.de"
}

variable "tutamail_dkim_2" {
  description = "The second tutamail dkim validation"
  type        = string
  default     = "s2.domainkey.tutanota.de"
}

variable "tutamail_mta" {
  description = "Tutamail mta sts value"
  type        = string
  default     = "mta-sts.tutanota.de"
}


variable "dmarc" {
  description = "The tutamail dmarc configuration"
  type        = string
  default     = "v=DMARC1; p=quarantine; adkim=s"
}
