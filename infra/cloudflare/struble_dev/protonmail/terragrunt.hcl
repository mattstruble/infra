include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  protonmail_verification = "protonmail-verification=3af6a5bd38e303153ff1f47e1ae84348550bf101"
  protonmail_dkim_1       = "protonmail.domainkey.dvu4n6x4rnptaek2rn6z223udeggcwpdxrtgeff4bxprwptwjxvda.domains.proton.ch."
  protonmail_dkim_2       = "protonmail2.domainkey.dvu4n6x4rnptaek2rn6z223udeggcwpdxrtgeff4bxprwptwjxvda.domains.proton.ch."
  protonmail_dkim_3       = "protonmail3.domainkey.dvu4n6x4rnptaek2rn6z223udeggcwpdxrtgeff4bxprwptwjxvda.domains.proton.ch."
  protonmail_dmarc        = "v=DMARC1; p=quarantine; rua=mailto:dmarc@struble.dev;"
}

terraform {
  source = "../../../../modules/cloudflare/protonmail"
}
