include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  txt_record_name  = "_atproto"
  txt_record_value = "did=did:plc:67hke6ig26o3huavs7mggdg2"
}

terraform {
  source = "../../../../terraform/cloudflare/txt_record"
}
