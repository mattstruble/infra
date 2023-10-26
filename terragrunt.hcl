locals {
  provider_vars = read_terragrunt_config(find_in_parent_folders("provider.hcl"))
  providers     = local.provider_vars.locals.providers
}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var-file=secrets.tfvars"
    ]
  }
}
