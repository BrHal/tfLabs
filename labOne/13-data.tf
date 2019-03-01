data "openstack_networking_network_v2" "terraform_external_network" {
  name = "${var.publicNetwork}"
}
