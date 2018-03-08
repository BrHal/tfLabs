resource "openstack_compute_secgroup_v2" "terraform_secgroup" {
  name        = "${var.infraName}_secgroup"
  description = "${var.infraName} security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
