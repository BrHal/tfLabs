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

variable "useTenantImage" {
  default = false
}

variable "operatingSystem" {
  default = "ubuntu"
}

variable "imageURLs" {
  type = "map"

  default = {
    ubuntu = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img"
    centos = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
    debian = "http://cdimage.debian.org/cdimage/openstack/current/debian-9.6.1-20181206-openstack-amd64.qcow2"
    fedora = "https://download.fedoraproject.org/pub/fedora/linux/releases/29/Cloud/x86_64/images/Fedora-Cloud-Base-29-1.2.x86_64.qcow2"
    suse   = "http://download.opensuse.org/repositories/Cloud:/Images:/Leap_15.0/images/openSUSE-Leap-15.0-OpenStack.x86_64-0.0.4-Buildlp150.12.80.qcow2"
  }
}

variable "imageNames" {
  type = "map"

  default = {
    ubuntu = "ubuntu-16.04-x64"
    centos = "centos-7-x86_64"
    debian = "debian-8.5.0-x64"
  }
}

variable "infraName" {
  default = "osa"
}

variable "DNSServers" {
  default = ["8.8.8.8", "8.8.8.4"]
}

variable "DeployNodeFlavor" {
  default = "m2.4medium"
}

variable "InfraNodeFlavor" {
  default = "m2.4medium"
}

variable "LogNodeFlavor" {
  default = "m2.4medium"
}

variable "ComputeNodeFlavor" {
  default = "m2.4medium"
}

variable "StorageNodeFlavor" {
  default = "m2.4medium"
}
