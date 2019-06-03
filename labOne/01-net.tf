resource "openstack_networking_network_v2" "terraform_network" {
  name           = "${var.infraName}_network"
  admin_state_up = "true"
}

