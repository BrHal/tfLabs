resource "openstack_networking_network_v2" "terraform_deploy_network" {
  name           = "${var.infraName}_deploy_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "terraform_ext1_network" {
  name           = "${var.infraName}_ext1_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "terraform_int1_network" {
  name           = "${var.infraName}_int1_network"
  admin_state_up = "true"
}

