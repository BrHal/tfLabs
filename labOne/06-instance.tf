resource "openstack_compute_instance_v2" "terraform_main_instance" {
  name            = "${var.infraName}_main_instance"
  image_id        = "${openstack_images_image_v2.terraform_image.id}"
  flavor_name     = "${var.flavorName}"
  key_pair        = "${openstack_compute_keypair_v2.terraform-keypair.id}"
  depends_on      = ["openstack_networking_router_v2.terraform_router"]
  security_groups = ["${openstack_networking_secgroup_v2.terraform_secgroup.id}"]

  network {
    name = "${var.infraName}_network"
  }
}
