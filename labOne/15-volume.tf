# resource "openstack_blockstorage_volume_v2" "terraform_main_volume" {
#   name        = "${var.infraName}_main_volume"
#   description = "${var.infraName} main volume"
#   size        = 30
#   volume_type = "local_volumes"
# }
