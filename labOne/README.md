# Lab One
Here's first of my terraform labs. It creates a basic single network infrastructure with one main instance ( The FIP-Addressable one ) and N worker instances ( set N to zero if you don't require any )

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

Edit 13-data.tf to fit your needs as flavor you want to apply to your instances

## An example with five variables defined
All values are free except publicNetWork which has to match your tenant's public network name ( TODO: see if we can guess it )

  - cloud = ...
  - pubKeyFile = ...
  - publicNetwork = "internet_floating_net"
  - infraName = "labOne-sample"
  - nbWorkers = 5

![labOne-sample](labOne-sample.png)
