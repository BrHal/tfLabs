resource "openstack_networking_router_interface_v2" "terraform_deploy_router_interface" {
  router_id = "${openstack_networking_router_v2.terraform_deploy_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform_deploy_network_sub1.id}"
}

resource "openstack_networking_router_interface_v2" "terraform_ext1_router_interface" {
  router_id = "${openstack_networking_router_v2.terraform_deploy_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform_ext1_network_sub1.id}"
}
