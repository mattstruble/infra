.DEFAULT_GOAL := plan

.PHONY: default
default: plan

.PHONY: init
init:
	@git config core.hooksPath "./git-hooks"
	@terragrunt run-all init

.PHONY: plan
plan : init
	@terragrunt run-all plan

.PHONY: apply
apply: plan
	@terragrunt run-all apply

.PHONY: format
format:
	@terraform fmt -recursive
	@terragrunt hclfmt .

.PHONY: check
check:
	@terraform fmt -check -recursive
	@terragrunt hclfmt . --terragrunt-check
