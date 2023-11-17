include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}
inputs = {
  protonmail_verification = "protonmail-verification=9899160bbe1832d273918e12e82881a8355f6a0d"
  protonmail_dkim_1       = "protonmail.domainkey.d5orkv42j4o6yk4iw26e23qeigav3bz7bxtufxprt3m7aunbljyrq.domains.proton.ch."
  protonmail_dkim_2       = "protonmail2.domainkey.d5orkv42j4o6yk4iw26e23qeigav3bz7bxtufxprt3m7aunbljyrq.domains.proton.ch."
  protonmail_dkim_3       = "protonmail3.domainkey.d5orkv42j4o6yk4iw26e23qeigav3bz7bxtufxprt3m7aunbljyrq.domains.proton.ch."
  protonmail_dmarc        = "v=DMARC1; p=quarantine; rua=mailto:dmarc@pillar.ml;"
}

terraform {
  source = "../../../../terraform/cloudflare/protonmail"
}
