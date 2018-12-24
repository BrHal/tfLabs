variable "sshKey" {}
variable "cloud" {}

variable "publicNetwork" {
  default = "internet"
}

variable "nbInfraNodes" {
  default = 0
}

variable "nbLogNodes" {
  default = 0
}

variable "nbComputeNodes" {
  default = 0
}

variable "nbStorageNodes" {
  default = 0
}

variable "deploy_CIDR" {
  default = "192.168.1.0/24"
}

variable "management_CIDR" {
  default = "172.29.236.0/22"
}

variable "tunnel_CIDR" {
  default = "172.29.240.0/22"
}

variable "storage_CIDR" {
  default = "172.29.244.0/22"
}

variable "imageName" {
  default = "ubuntu-16.04-x64"
}

variable "imageURL" {
  default = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img"
}

variable "infraName" {
  default = "OSA"
}

variable "DNSServers" {
  default = ["8.8.8.8", "8.8.8.4"]
}

variable "ansibleManaged" {
  default = false
}