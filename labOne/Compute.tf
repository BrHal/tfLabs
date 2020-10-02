resource "openstack_compute_instance_v2" "terraform_main_instance" {
  name       = "${var.infraName}_main_instance"
  image_id   = openstack_images_image_v2.terraform_image.id
  flavor_id  = data.openstack_compute_flavor_v2.terraform_best_flavor.id
  key_pair   = openstack_compute_keypair_v2.terraform-keypair.id
  depends_on = [openstack_networking_router_v2.terraform_router]

  security_groups = [
    openstack_networking_secgroup_v2.terraform_remote_secgroup.id,
    openstack_networking_secgroup_v2.terraform_local_secgroup.id,
  ]

  network {
    uuid = openstack_networking_network_v2.terraform_service_network.id
  }
  user_data = data.template_file.cloud-init-node.rendered
}

resource "openstack_compute_instance_v2" "terraform_worker_instance" {
  count           = var.nbWorkers
  name            = "${var.infraName}_worker-${format("%02d", count.index + 1)}_instance"
  image_id        = openstack_images_image_v2.terraform_image.id
  flavor_id       = data.openstack_compute_flavor_v2.terraform_best_flavor.id
  key_pair        = openstack_compute_keypair_v2.terraform-ansible-keypair.id
  network {
    uuid = openstack_networking_network_v2.terraform_service_network.id
  }

  user_data = data.template_file.cloud-init-node.rendered
}

resource "openstack_compute_keypair_v2" "terraform-keypair" {
  name       = "${var.infraName}-keypair"
  public_key = file(var.pubKeyFile)
}

resource "openstack_compute_keypair_v2" "terraform-ansible-keypair" {
  name       = "${var.infraName}-ansible-keypair"
  public_key = file("AnsibleKey.pub")
}
resource "openstack_compute_volume_attach_v2" "terraform_main_attachment" {
  instance_id = openstack_compute_instance_v2.terraform_main_instance.id
  volume_id   = openstack_blockstorage_volume_v2.terraform_main_volume.id
}

resource "openstack_compute_volume_attach_v2" "terraform_worker_volume_attachment" {
  count       = var.nbWorkers
  instance_id = openstack_compute_instance_v2.terraform_worker_instance.*.id[count.index]
  volume_id   = openstack_blockstorage_volume_v2.terraform_worker_volume.*.id[count.index]
}

resource "openstack_compute_interface_attach_v2" "terraform_worker_interface_attachment" {
  count       = 2
  instance_id = openstack_compute_instance_v2.terraform_worker_instance.*.id[count.index]
  port_id     = openstack_networking_port_v2.terraform_worker_port.*.id[count.index]
}
