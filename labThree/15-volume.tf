resource "openstack_blockstorage_volume_v2" "terraform_db_volume" {
  count       = "${var.nbDBNodes}"
  name        = "${var.infraName}_db_volume_${format("%02d", count.index +1)}"
  description = "${var.infraName} db volume ${format("%02d", count.index +1)}"
  size        = 10
}
