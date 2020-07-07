#!/bin/bash
labs="lab1 lab2 lab3"

for state in $labs
do
 terraform destroy  -var-file=terraform.tfvars.${state}  -state=terraform.tfstate.${state}
done
