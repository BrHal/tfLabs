resource "openstack_networking_floatingip_v2" "terraform_floatip" {
  pool = "${var.publicNetwork}"
}

resource "openstack_compute_floatingip_associate_v2" "terraform_floatip" {
  floating_ip = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
  instance_id = "${openstack_compute_instance_v2.terraform_deploy_instance.id}"
}
