.PHONY: init
init:
	@git config core.hooksPath "./git-hooks"
	@terragrunt run-all init

.PHONY: plan
plan : init
	@terragrunt run-all init

.PHONY: apply
apply: plan
	@terragrunt run-all plan

.PHONY: format
format:
	@terragrunt hclfmt .

.PHONY: check
check:
	@terragrunt hclfmt . --terragrunt-check
