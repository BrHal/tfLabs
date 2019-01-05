resource "openstack_images_image_v2" "terraform_upstream_image" {
  name             = "${var.infraName}_${var.operatingSystem}_image"
  image_source_url = "${var.imageURLs["${var.operatingSystem}"]}"
  container_format = "bare"
  disk_format      = "qcow2"
}

data "openstack_images_image_v2" "terraform_tenant_image" {
  name        = "${var.imageNames["${var.operatingSystem}"]}"
  most_recent = true
}
