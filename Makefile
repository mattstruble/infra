.PHONY: init
init:
	git config core.hooksPath "./git-hooks"
	terraform init

.PHONY: plan
plan : init
	terraform plan -var-file secrets.tfvars

.PHONY: apply
apply: plan
	terraform apply -var-file secrets.tfvars

.PHONY: format
format:
	@terragrunt hclfmt .

.PHONY: check
check:
	@terragrunt hclfmt . --terragrunt-check
