resource "openstack_networking_network_v2" "terraform_service_network" {
  name           = "${var.infraName}_service_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "terraform_worker_network" {
  name           = "${var.infraName}_worker_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "terraform_service_network_sub" {
  name            = "${var.infraName}_service_network_sub1"
  network_id      = openstack_networking_network_v2.terraform_service_network.id
  cidr            = var.service_CIDR
  ip_version      = 4
  dns_nameservers = var.DNSServers
}

resource "openstack_networking_subnet_v2" "terraform_worker_network_sub" {
  name            = "${var.infraName}_worker_network_sub1"
  network_id      = openstack_networking_network_v2.terraform_worker_network.id
  cidr            = var.worker_CIDR
  ip_version      = 4
  no_gateway      = "true"
  enable_dhcp     = "false"
}

resource "openstack_networking_router_v2" "terraform_router" {
  name                = "${var.infraName}_router"
  external_network_id = data.openstack_networking_network_v2.terraform_external_network.id
  admin_state_up      = "true"
}

resource "openstack_networking_router_interface_v2" "terraform_router_service_interface" {
  router_id = openstack_networking_router_v2.terraform_router.id
  subnet_id = openstack_networking_subnet_v2.terraform_service_network_sub.id
}

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
  security_group_id = openstack_networking_secgroup_v2.terraform_remote_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_20000" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 20000
  port_range_max    = 20000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.terraform_remote_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "terraform_remote_secgroup_rule_ping" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = 8
  port_range_max    = 0
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.terraform_remote_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "terraform_local_secgroup_rule_ping" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = 8
  port_range_max    = 0
  remote_group_id   = openstack_networking_secgroup_v2.terraform_local_secgroup.id
  security_group_id = openstack_networking_secgroup_v2.terraform_local_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "terraform_local_secgroup_rule_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_group_id   = openstack_networking_secgroup_v2.terraform_local_secgroup.id
  security_group_id = openstack_networking_secgroup_v2.terraform_local_secgroup.id
}

resource "openstack_networking_floatingip_v2" "terraform_floatip" {
  pool = var.publicNetwork
}

resource "openstack_compute_floatingip_associate_v2" "terraform_floatip" {
  floating_ip = openstack_networking_floatingip_v2.terraform_floatip.address
  instance_id = openstack_compute_instance_v2.terraform_main_instance.id
}
