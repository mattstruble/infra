include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  icloudmail_verification = "apple-domain=mWN9NAbG7qXAliVd"
  icloudmail_dmarc = "v=DMARC1; p=quarantine; adkim=s; rua=mailto:dmarc@struble.dev"
}

terraform {
  source = "../../../../terraform/cloudflare/icloudmail/"
}
