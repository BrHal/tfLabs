resource "openstack_compute_keypair_v2" "terraform-keypair" {
  name       = "${var.infraName}-keypair"
  public_key = file(var.pubKeyFile)
}

