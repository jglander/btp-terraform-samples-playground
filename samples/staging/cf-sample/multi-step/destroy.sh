#!/bin/sh

cd step-2

terraform destroy -var-file=vars.tfvars -auto-approve
rm vars.tfvars

cd ../step-1

terraform destroy -var-file=vars.tfvars -auto-approve

cd ..