.DEFAULT_GOAL := plan

TERRAGRUNT_WORKING_DIR := ./infra

.PHONY: default
default: plan

.PHONY: init
init:
	@git config core.hooksPath "./git-hooks"
	@chmod u+x ./git-hooks/post-commit
	@terragrunt run-all init --terragrunt-working-dir ${TERRAGRUNT_WORKING_DIR}

.PHONY: plan
plan : init
	@terragrunt run-all plan --terragrunt-working-dir ${TERRAGRUNT_WORKING_DIR}

.PHONY: apply
apply: plan
	@terragrunt run-all apply --terragrunt-working-dir ${TERRAGRUNT_WORKING_DIR}

.PHONY: format
format:
	@terraform fmt -recursive
	@terragrunt hclfmt .

.PHONY: check
check:
	@terraform fmt -check -recursive
	@terragrunt hclfmt . --terragrunt-check
