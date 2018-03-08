variable "keyPair" {}
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

variable "infraName" {
  default = "terraform"
}
