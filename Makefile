.PHONY: init
init:
	terraform init

.PHONY: apply
apply:
	terraform apply -var-file secrets.tfvars
