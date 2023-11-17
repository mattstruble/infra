locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region_name = local.region_vars.locals.region_name

  namespace_vars = read_terragrunt_config(find_in_parent_folders("namespace.hcl"))
  namespace      = local.namespace_vars.locals.namespace

  stage_vars = read_terragrunt_config(find_in_parent_folders("stage.hcl"))
  stage      = local.stage_vars.locals.stage

  name_vars = read_terragrunt_config("name.hcl")
  name      = local.name_vars.locals.name
}

inputs = {
  namespace = local.namespace
  region    = local.region_name
  stage     = local.stage
  name      = local.name

  label_context = {
    label_key_case = "title"
    label_order    = ["namespace", "stage", "name", "attributes"]
    namespace      = local.namespace
    environment    = local.region_name
    name           = local.name
    stage          = local.stage
    tags = {
      Terraform     = true,
      Repo          = "https://github.com/mattstruble/infra"
      Repo_relative = path_relative_to_include()
      By            = get_aws_caller_identity_arn()
    }

    attributes          = []
    enabled             = true,
    descriptor_formats  = {}
    label_value_case    = null,
    label_as_tags       = ["unset"]
    regex_replace_chars = null
    tenant              = null
    additional_tag_map  = {}
    delimiter           = null
    id_length_limit     = null
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
