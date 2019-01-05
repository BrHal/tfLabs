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

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_keystone" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5000
  port_range_max    = 5000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_os1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8000
  port_range_max    = 8004
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_os2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8082
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_os3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8386
  port_range_max    = 8386
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_os4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8774
  port_range_max    = 8776
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_os5" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9292
  port_range_max    = 9292
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_remote_secgroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_os6" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9696
  port_range_max    = 9696
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

resource "openstack_networking_secgroup_rule_v2" "terraform_local_secgroup_rule_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_group_id   = "${openstack_networking_secgroup_v2.terraform_local_secgroup.id}"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_local_secgroup.id}"
}
