# Lab Two
Here's second of my terraform labs. It creates a ceph-OSA infrastructure as required on https://docs.openstack.org/openstack-ansible/rocky/user/ceph/full-deploy.html, as a provisioner, it also runs bootstrap-ansible.sh on the deploy node.

Although building openstack on a cloud is only for learning purposes, most of tf code here can - and hopefully will - be re-used to build multi-tiers architectures.

Two Private/Public sample keypairs are provided for convenience but I strongly recommend to build new ones. This is done as simply as running newKeys.sh. It will generate two keypairs - Admin and Ansible - named so, accordingly to tf code.

## Lab requirements on your client station :
 - packages : git, terraform, openstack-cli (optionnal)
 - {home}/.config/openstack/clouds.yaml holding your tenants credentials and URL

## Lab requirements on your tenant :
 - a public network with a FIP pool
 - enough vCPU, storage, secgroup, RAM in quotas

## How to :
Set variables : Read and use terraform.tfvars.sample :
 - copy terraform.tfvars.sample to terraform.tfvars
 - edit terraform.tfvars variables as needed

Launch terraform
 - terraform init
 - terraform plan
 - terraform apply

Debug your HCL code, evaluate your plan contents, etc...
 - terraform console

Renew your public/private key pairs
 - ./newKeys.sh Warning! if you have a running /create infrastrucyure, keep a safe copy of AnsibleKey.pem

## An example of terraform.tfvars
```
# mandatory values
cloud = "mycloud"

# optional values
publicNetwork = "my_public_net"
infraName = "osa"
useTenantImage = false
operatingSystem ="ubuntu"
nbInfraNodes= 3
nbLogNodes= 1
nbComputeNodes = 1
nbStorageNodes = 3
```
