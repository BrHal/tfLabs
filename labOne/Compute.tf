resource "openstack_compute_instance_v2" "terraform_gw_instance" {
  name       = "${var.infraName}_gw_instance"
  image_id   = openstack_images_image_v2.terraform_image.id
  flavor_id  = data.openstack_compute_flavor_v2.terraform_best_flavor.id
  key_pair   = openstack_compute_keypair_v2.terraform-keypair.id
  depends_on = [openstack_networking_router_v2.terraform_router]
  network {
    port = openstack_networking_port_v2.terraform_service_port.id
  }
  network {
    port = openstack_networking_port_v2.terraform_worker_gw_port.id
  }
  user_data = data.template_file.cloud-init-gw.rendered
  config_drive = true
}

resource "openstack_compute_instance_v2" "terraform_worker_instance" {
  count           = var.nbWorkers
  name            = "${var.infraName}_worker-${format("%02d", count.index + 1)}_instance"
  image_id        = openstack_images_image_v2.terraform_image.id
  flavor_id       = data.openstack_compute_flavor_v2.terraform_best_flavor.id
  key_pair        = openstack_compute_keypair_v2.terraform-ansible-keypair.id
  network {
    port          = openstack_networking_port_v2.terraform_worker_port.*.id[count.index]
  }

  network {
    port          = openstack_networking_port_v2.terraform_internal_port.*.id[count.index]
  }

  user_data = data.template_file.cloud-init-worker.rendered
  config_drive = true
}

resource "openstack_compute_keypair_v2" "terraform-keypair" {
  name       = "${var.infraName}-keypair"
  public_key = file(var.pubKeyFile)
}

resource "openstack_compute_keypair_v2" "terraform-ansible-keypair" {
  name       = "${var.infraName}-ansible-keypair"
  public_key = file("AnsibleKey.pub")
}
resource "openstack_compute_volume_attach_v2" "terraform_gw_attachment" {
  instance_id = openstack_compute_instance_v2.terraform_gw_instance.id
  volume_id   = openstack_blockstorage_volume_v2.terraform_gw_volume.id
}

resource "openstack_compute_volume_attach_v2" "terraform_worker_volume_attachment" {
  count       = var.nbWorkers
  instance_id = openstack_compute_instance_v2.terraform_worker_instance.*.id[count.index]
  volume_id   = openstack_blockstorage_volume_v2.terraform_worker_volume.*.id[count.index]
}
