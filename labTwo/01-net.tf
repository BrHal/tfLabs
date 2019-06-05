resource "openstack_networking_network_v2" "terraform_deploy_network" {
  name           = "${var.infraName}_deploy_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "terraform_management_network" {
  name           = "${var.infraName}_management_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "terraform_tunnel_network" {
  name           = "${var.infraName}_tunnel_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "terraform_storage_network" {
  name           = "${var.infraName}_storage_network"
  admin_state_up = "true"
}

