resource "openstack_networking_secgroup_v2" "terraform_secgroup" {
  name        = "${var.infraName}_secgroup"
  description = "${var.infraName} security group"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_secgroup_rule1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_secgroup.id}"
}
