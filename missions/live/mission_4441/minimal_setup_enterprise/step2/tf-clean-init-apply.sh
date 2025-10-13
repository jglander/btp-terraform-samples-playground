#!/bin/sh

rm -rf .terraform
rm .terraform.lock.hcl
rm terraform.tfstate

terraform init
terraform apply -var-file=terraform.tfvars
