#!/bin/bash

labs="lab1 lab2 lab3"

for state in $labs
do
# terraform plan -var-file=terraform.tfvars.${state} -state=terraform.tfstate.${state}
 terraform apply -auto-approve -var-file=terraform.tfvars.${state} -state=terraform.tfstate.${state}
done

for state in $labs
do
echo "=========================================="
 echo ${state} :
 echo "---------------------"
 terraform output -state=terraform.tfstate.${state}
done
echo "=========================================="
