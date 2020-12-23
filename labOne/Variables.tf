variable "cloud" {
}

variable "flavorName" {
}

variable "pubKeyFile" {
  default = "adminKey.pub"
}

variable "privKeyFile" {
  default = "adminKey.pem"
}

variable "publicNetwork" {
  default = "public"
}

variable "nbWorkers" {
  default = 1
}

variable "service_CIDR" {
  default = "192.168.1.0/24"
}

variable "worker_CIDR" {
  default = "192.168.2.0/24"
}

variable "internal_CIDR" {
  default = "192.168.3.0/24"
}

variable "imageName" {
  default = "centos7-x64"
}

variable "imageURL" {
  default = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
}

variable "infraName" {
  default = "terraform"
}

variable "DNSServers" {
  default = ["8.8.8.8", "8.8.8.4"]
}

variable "useProvisioner" {
  default = false
}

variable "operatingSystem" {
  default = "centos"
}

variable "worker_nic" {
  default = "eth0"
}

variable "out_nic" {
  default = "eth0"
}
