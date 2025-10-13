#!/bin/sh

rm -rf .terraform
rm .terraform.lock.hcl
rm terraform.tfstate

terraform init
terraform plan -var-file=terraform.tfvars
