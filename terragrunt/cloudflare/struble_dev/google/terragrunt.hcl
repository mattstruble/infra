include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  txt_record_value = "google-site-verification=rKLUGfAqMz12e1zb1-E1wSPwBUu_UU3tE25oCm5BaZQ" # pragma: allowlist secret
}

terraform {
  source = "../../../../terraform/cloudflare/txt_record"
}
