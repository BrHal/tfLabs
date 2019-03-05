resource "openstack_compute_volume_attach_v2" "terraform_db_attachment" {
  count       = "${var.nbDBNodes}"
  instance_id = "${openstack_compute_instance_v2.terraform_db_instance.*.id[count.index]}"
  volume_id   = "${openstack_blockstorage_volume_v2.terraform_db_volume.*.id[count.index]}"
}
