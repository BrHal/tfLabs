resource "openstack_blockstorage_volume_v2" "terraform_main_volume" {
  name        = "${var.infraName}_main_volume"
  description = "${var.infraName} main volume"
  size        = 30
}

resource "openstack_blockstorage_volume_v2" "terraform_worker_volume" {
  count       = "${var.nbWorkers}"
  name        = "${var.infraName}_worker-${format("%02d", count.index +1)}_volume"
  description = "${var.infraName} worker volume ${format("%02d", count.index +1)}"
  size        = 30
}
