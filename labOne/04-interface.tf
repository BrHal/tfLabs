resource "openstack_networking_router_interface_v2" "terraform_router_interface" {
  router_id = "${openstack_networking_router_v2.terraform_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform_network_sub1.id}"
}
