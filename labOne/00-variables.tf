variable "sshKey" {}
variable "externalNetworkID" {}
variable "flavorName" {}

variable "poolFIP" {
  default = "internet"
}

variable "CIDR" {
  default = "192.168.1.0/24"
}

variable "imageName" {
  default = "ubuntu-16.04-x64"
}

variable "imageURL" {
  default = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img"
}

variable "infraName" {
  default = "terraform"
}

variable "DNSServers" {
  default = ["8.8.8.8", "8.8.8.4"]
}
