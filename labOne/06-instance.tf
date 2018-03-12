resource "openstack_compute_instance_v2" "terraform_test_instance" {
  name            = "${var.infraName}_test_instance"
  image_name      = "${var.imageName}"
  flavor_name     = "${var.flavorName}"
  key_pair        = "${openstack_compute_keypair_v2.terraform-keypair.id}"
  depends_on      = ["openstack_networking_router_v2.terraform_router"]
  security_groups = ["${openstack_compute_secgroup_v2.terraform_secgroup.id}"]

  network {
    name = "${var.infraName}_network"
  }
}
