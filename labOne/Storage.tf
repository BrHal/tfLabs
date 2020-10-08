resource "openstack_images_image_v2" "terraform_image" {
  name             = "${var.infraName}_image"
  image_source_url = var.imageURL
  container_format = "bare"
  disk_format      = "qcow2"
}

resource "openstack_blockstorage_volume_v2" "terraform_gw_volume" {
  name        = "${var.infraName}_gw_volume"
  description = "${var.infraName} gw volume"
  size        = 30
}

resource "openstack_blockstorage_volume_v2" "terraform_worker_volume" {
  count       = var.nbWorkers
  name        = "${var.infraName}_worker-${format("%02d", count.index +1)}_volume"
  description = "${var.infraName} worker volume ${format("%02d", count.index +1)}"
  size        = 30
}
