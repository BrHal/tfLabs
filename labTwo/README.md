# Lab Two
Here's second of my terraform labs. It creates a ceph-OSA infrastructure as required on https://docs.openstack.org/openstack-ansible/rocky/user/ceph/full-deploy.html

## Lab requirements on your client station :
 - packages : git, terraform, openstack-cli (optionnal)
 - {home}/.config/openstack/clouds.yaml holding your tenants credentials and URL

## Lab requirements on your tenant :
 - a public network with a FIP pool
 - enough vCPU, storage, secgroup, RAM

## How to :
Read and use terraform.tfvars.sample to set variables :
 - copy terraform.tfvars.sample to terraform.tfvars
 - edit terraform.tfvars variables as needed

To launch terraform
 - terraform init
 - terraform plan
 - terraform apply

## An example
```
infraName = "labTwo"
cloud = "myCloud"
sshKey= "ssh-rsa ..."
publicNetwork = "public_net"
useTenantImage = true
nbInfraNodes= 1
nbLogNodes= 1
nbComputeNodes = 1
nbStorageNodes = 1
```
