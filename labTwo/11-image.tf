resource "openstack_images_image_v2" "terraform_upstream_image" {
  name             = "${var.infraName}_image"
  image_source_url = "${var.imageURL}"
  container_format = "bare"
  disk_format      = "qcow2"
}
