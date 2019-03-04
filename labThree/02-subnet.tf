resource "openstack_networking_subnet_v2" "terraform_deploy_network_sub1" {
  name            = "${var.infraName}_deploy_network_sub1"
  network_id      = "${openstack_networking_network_v2.terraform_deploy_network.id}"
  cidr            = "${var.deploy_CIDR}"
  ip_version      = 4
  dns_nameservers = "${var.DNSServers}"
}

resource "openstack_networking_subnet_v2" "terraform_ext1_network_sub1" {
  name        = "${var.infraName}_ext1_network_sub1"
  network_id  = "${openstack_networking_network_v2.terraform_ext1_network.id}"
  cidr        = "${var.ext1_CIDR}"
  no_gateway  = false
  enable_dhcp = true
  ip_version  = 4
}

resource "openstack_networking_subnet_v2" "terraform_int1_network_sub1" {
  name       = "${var.infraName}_int1_network_sub1"
  network_id = "${openstack_networking_network_v2.terraform_int1_network.id}"
  cidr       = "${var.int1_CIDR}"

  no_gateway  = true
  enable_dhcp = true
  ip_version  = 4
}
