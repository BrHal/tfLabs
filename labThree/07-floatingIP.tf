resource "openstack_networking_floatingip_v2" "terraform_floatip" {
  pool = var.publicNetwork
}

resource "openstack_compute_floatingip_associate_v2" "terraform_floatip" {
  floating_ip = openstack_networking_floatingip_v2.terraform_floatip.address
  instance_id = openstack_compute_instance_v2.terraform_deploy_instance.id
}

resource "openstack_networking_floatingip_v2" "terraform_lb_floatip" {
  pool    = var.publicNetwork
  port_id = openstack_lb_loadbalancer_v2.terraform_ext_lb.vip_port_id
}

