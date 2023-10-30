locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region_name = local.region_vars.locals.region_name

  namespace_vars = read_terragrunt_config(find_in_parent_folders("namespace.hcl"))
  namespace = local.namespace_vars.locals.namespace

  name_vars = read_terragrunt_config("name.hcl")
  name = local.name_vars.locals.name
}

inputs = {
    namespace = local.namespace
    environment = local.region_name
    name = local.name

    tags = {
        terraform = true,
        repo = "https://github.com/mattstruble/infra"
    }
}

generate "provider" {

  path      = "provider_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
}

provider "aws" {
    region = "${local.region_name}"
}
EOF
}
