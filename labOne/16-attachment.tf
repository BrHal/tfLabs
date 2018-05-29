resource "openstack_compute_volume_attach_v2" "terraform_main_attachment" {
  instance_id = "${openstack_compute_instance_v2.terraform_main_instance.id}"
  volume_id = "${openstack_blockstorage_volume_v2.terraform_main_volume.id}"
}
