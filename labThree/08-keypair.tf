resource "openstack_compute_keypair_v2" "terraform-admin-keypair" {
  name       = "${var.infraName}-admin-keypair"
  public_key = file("AdminKey.pub")
}

resource "openstack_compute_keypair_v2" "terraform-ansible-keypair" {
  name       = "${var.infraName}-ansible-keypair"
  public_key = file("AnsibleKey.pub")
}

