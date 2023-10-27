locals {
    region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

    account_region      = local.region_vars.locals.region_name
}
remote_state {
    backend = "s3"

    config = {
        bucket = "github-infra-cicd-${local.account_region}"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = local.account_region
        dynamodb_table = "github-infra-cicd-locktable"
        encrypt = true
    }

    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}
