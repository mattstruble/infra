include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

include "root" {
  path = find_in_parent_folders()
}


terraform {
  source = "../../../../../terraform/aws/minecraft"
}
