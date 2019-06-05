# resource "openstack_blockstorage_volume_v2" "terraform_os_volume" {
#   name        = "${var.infraName}_os_volume"
#   description = "${var.infraName} operating system volume"
#   size        = 10
#   image_id  = "${openstack_images_image_v2.terraform_upstream_image.id}"
# }
