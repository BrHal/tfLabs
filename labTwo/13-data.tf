data "openstack_networking_network_v2" "terraform_external_network" {
  name = "${var.publicNetwork}"
}

data "openstack_compute_flavor_v2" "terraform_deploy_flavor" {
  name = "tf.04V.04G.0G"
}

data "openstack_compute_flavor_v2" "terraform_infra_flavor" {
  name = "tf.04V.08G.0G"
}

data "openstack_compute_flavor_v2" "terraform_log_flavor" {
  name = "tf.04V.08G.0G"
}

data "openstack_compute_flavor_v2" "terraform_compute_flavor" {
  name = "tf.16V.64G.0G"
}

data "openstack_compute_flavor_v2" "terraform_storage_flavor" {
  name = "tf.04V.08G.0G"
}

data "openstack_images_image_v2" "terraform_base_image" {
  name = "${var.imageName}"
  most_recent = true
}
