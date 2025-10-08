.PHONY: fmt init plan apply destroy lint

fmt:
	terraform fmt -recursive

init:
	terraform init -upgrade

plan:
	terraform plan -out=plan.out

apply:
	terraform apply -auto-approve plan.out

destroy:
	terraform destroy -auto-approve

lint:
	tfsec . && checkov -d .
