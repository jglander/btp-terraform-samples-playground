#!/bin/sh

cd step-1

terraform init
terraform apply -var-file=vars.tfvars -auto-approve
terraform output > ../step-2/vars.tfvars

cd ../step-2

terraform init
terraform apply -var-file=vars.tfvars -auto-approve

cd ..