resource "openstack_networking_subnet_v2" "terraform_deploy_network_sub1" {
  name            = "${var.infraName}_deploy_network_sub1"
  network_id      = "${openstack_networking_network_v2.terraform_deploy_network.id}"
  cidr            = "${var.deploy_CIDR}"
  ip_version      = 4
  dns_nameservers = "${var.DNSServers}"
}

resource "openstack_networking_subnet_v2" "terraform_management_network_sub1" {
  name        = "${var.infraName}_management_network_sub1"
  network_id  = "${openstack_networking_network_v2.terraform_management_network.id}"
  cidr        = "${var.management_CIDR}"
  no_gateway  = true
  enable_dhcp = true
  ip_version  = 4
}

resource "openstack_networking_subnet_v2" "terraform_tunnel_network_sub1" {
  name        = "${var.infraName}_tunnel_network_sub1"
  network_id  = "${openstack_networking_network_v2.terraform_tunnel_network.id}"
  cidr        = "${var.tunnel_CIDR}"
  no_gateway  = true
  enable_dhcp = true
  ip_version  = 4
}

resource "openstack_networking_subnet_v2" "terraform_storage_network_sub1" {
  name        = "${var.infraName}_storage_network_sub1"
  network_id  = "${openstack_networking_network_v2.terraform_storage_network.id}"
  cidr        = "${var.storage_CIDR}"
  no_gateway  = true
  enable_dhcp = true
  ip_version  = 4
}
