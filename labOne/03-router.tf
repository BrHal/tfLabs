resource "openstack_networking_router_v2" "terraform_router" {
name = "${var.infraName}_router"
external_network_id = "${var.externalNetworkID}"
admin_state_up = "true"
}
