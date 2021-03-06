# Lab Three
Here's the third of my terraform labs. It creates a LAMP-like infrastructure. cloud-init does not perform web server, app language, or db package installation; those are up to user choice (apache, nginx or any other, php, nodejs, python or any other, postgresql, mariadb or any other). Only packages provided to nodes are monitoring and perf tools.

Deploy node comes with ansible installed, required keys to ssh to nodes and a generated inventory.

Two Private/Public sample keypairs are provided for convenience but I strongly recommend to build new ones. This is done as simply as running ./newKeys.sh. It will generate two keypairs - Admin and Ansible - named so, accordingly to tf code.

Check /opt/terraform folder on your deploy node, it's a starting point to your ansible automation.

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
 - ./newKeys.sh Warning! if you have a running or created infrastructure, keep a safe copy of AnsibleKey.pem and AdminKey.pem

## An example of terraform.tfvars for a linux-nginx-postgres-php
```
# mandatory values
cloud = "mycloud"

# optional values
publicNetwork = "my_public_net"
infraName = "lnpp"
useTenantImage = false
operatingSystem ="ubuntu"
nbWebNodes= 3
nbDBNodes = 2
```
## TODO:
 - add an internal lb for DB cluster

 ![LAMP-topology](LAMP-topology.png)
