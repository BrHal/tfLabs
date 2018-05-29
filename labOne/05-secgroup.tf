resource "openstack_networking_secgroup_v2" "terraform_remote_secgroup" {
  name        = "${var.infraName}_remote_secgroup"
  description = "${var.infraName} Remote (outbound) security group"
}

resource "openstack_networking_secgroup_v2" "terraform_local_secgroup" {
  name        = "${var.infraName}_local_secgroup"
  description = "${var.infraName} Local security group"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_local_secgroup_rule_ping" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = 8
  port_range_max    = 0
  remote_group_id   = "${openstack_networking_secgroup_v2.terraform_local_secgroup.id}"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_local_secgroup.id}"
}
