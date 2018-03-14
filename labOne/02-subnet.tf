resource "openstack_networking_subnet_v2" "terraform_network_sub1" {
  name            = "${var.infraName}_network_sub1"
  network_id      = "${openstack_networking_network_v2.terraform_network.id}"
  cidr            = "${var.CIDR}"
  ip_version      = 4
  dns_nameservers = "${var.DNSServers}"
}
