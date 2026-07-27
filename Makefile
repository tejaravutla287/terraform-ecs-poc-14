.PHONY: init plan apply destroy build-local run-local

ENV ?= dev
TF_DIR = terraform
APP_DIR = app

init:
	cd $(TF_DIR) && terraform init

plan:
	cd $(TF_DIR) && terraform plan -var-file="$(ENV).tfvars"

apply:
	cd $(TF_DIR) && terraform apply -var-file="$(ENV).tfvars" -auto-approve

destroy:
	cd $(TF_DIR) && terraform destroy -var-file="$(ENV).tfvars" -auto-approve

build-local:
	docker build -t ecs-website-poc:local $(APP_DIR)

run-local: build-local
	docker run -p 8080:80 --env NODE_ENV=local ecs-website-poc:local
