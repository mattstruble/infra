include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  txt_record_value = "brave-ledger-verification=138bf6ec62cc8577da73470ebe5e930fbc29ab644c4921ba6ea857ecb7591b0e"
}

terraform {
  source = "../../../../modules/cloudflare/txt_record"
}
