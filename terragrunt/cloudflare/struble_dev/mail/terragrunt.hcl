include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  tutamail_verification = "t-verify=27145c926d106c1c4b8b4d7c4a17edfa"
  dmarc                 = "v=DMARC1; p=quarantine; adkim=s; rua=mailto:dmarc@struble.dev;"
}

terraform {
  source = "../../../../terraform/cloudflare/tutamail"
}
