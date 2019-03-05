resource "openstack_lb_loadbalancer_v2" "terraform_ext_lb" {
  vip_subnet_id      = "${openstack_networking_subnet_v2.terraform_ext1_network_sub1.id}"
  name               = "${var.infraName}_ext_lb"
  security_group_ids = ["${openstack_networking_secgroup_v2.terraform_service_secgroup.id}"]
}

resource "openstack_lb_listener_v2" "terraform_ext_http_listener" {
  name            = "${var.infraName}_ext_http_listener"
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.terraform_ext_lb.id}"
}

resource "openstack_lb_pool_v2" "terraform_ext_http_pool" {
  name        = "${var.infraName}_ext_http_pool"
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = "${openstack_lb_listener_v2.terraform_ext_http_listener.id}"

  persistence {
    type = "HTTP_COOKIE"
  }
}

resource "openstack_lb_member_v2" "terraform_ext_http_pool_member" {
  count         = "${var.nbWebNodes}"
  pool_id       = "${openstack_lb_pool_v2.terraform_ext_http_pool.id}"
  protocol_port = 80
  subnet_id     = "${openstack_networking_subnet_v2.terraform_ext1_network_sub1.id}"
  address       = "${openstack_compute_instance_v2.terraform_web_instance.*.network.1.fixed_ip_v4[count.index]}"
}
