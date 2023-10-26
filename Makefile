.PHONY: init
init:
	terraform init

.PHONY: apply
apply: init
	terraform apply -var-file secrets.tfvars
