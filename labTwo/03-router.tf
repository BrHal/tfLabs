resource "openstack_networking_router_v2" "terraform_deploy_router" {
  name                = "${var.infraName}_deploy_router"
  external_network_id = "${data.openstack_networking_network_v2.terraform_external_network.id}"
  admin_state_up      = "true"

}
