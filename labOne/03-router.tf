resource "openstack_networking_router_v2" "terraform_router" {
  name                = "${var.infraName}_router"
  external_network_id = "${data.openstack_networking_network_v2.terraform_external_network.id}"
  admin_state_up      = "true"

}
