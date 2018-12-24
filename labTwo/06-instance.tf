
resource "openstack_compute_instance_v2" "terraform_deploy_instance" {
  name            = "${var.infraName}_deploy_instance"
  flavor_id       = "${data.openstack_compute_flavor_v2.terraform_deploy_flavor.id}"
  key_pair        = "${openstack_compute_keypair_v2.terraform-keypair.id}"
  depends_on      = ["openstack_networking_router_v2.terraform_deploy_router",
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1"]
  security_groups = ["${openstack_networking_secgroup_v2.terraform_remote_secgroup.name}",
                    "${openstack_networking_secgroup_v2.terraform_local_secgroup.name}"]
  block_device{
    source_type = "image"
    uuid        = "${openstack_images_image_v2.terraform_upstream_image.id}"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 10
  }
  network {
    name = "${var.infraName}_deploy_network"
  }
  user_data = "${file("deploy.yml")}"
}

resource "openstack_compute_instance_v2" "terraform_infra_instance" {
  count           = "${var.nbInfraNodes}"
  name            = "${var.infraName}_infra-${format("%02d", count.index +1)}_instance"
  flavor_id       = "${data.openstack_compute_flavor_v2.terraform_infra_flavor.id}"
  key_pair        = "${openstack_compute_keypair_v2.terraform-keypair.id}"
  depends_on      = ["openstack_networking_router_v2.terraform_deploy_router",
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1",
    "openstack_networking_subnet_v2.terraform_management_network_sub1",
    "openstack_networking_subnet_v2.terraform_tunnel_network_sub1"]
  security_groups = ["${openstack_networking_secgroup_v2.terraform_local_secgroup.name}"]
  block_device{
    source_type = "image"
    uuid        = "${openstack_images_image_v2.terraform_upstream_image.id}"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 10
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }

  network {
    name = "${var.infraName}_deploy_network"
  }
  network {
    name = "${var.infraName}_management_network"
  }
  network {
    name = "${var.infraName}_tunnel_network"
  }
}

resource "openstack_compute_instance_v2" "terraform_log_instance" {
  count           = "${var.nbLogNodes}"
  name            = "${var.infraName}_log-${format("%02d", count.index +1)}_instance"
  flavor_id       = "${data.openstack_compute_flavor_v2.terraform_log_flavor.id}"
  key_pair        = "${openstack_compute_keypair_v2.terraform-keypair.id}"
  depends_on      = ["openstack_networking_router_v2.terraform_deploy_router",
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1",
    "openstack_networking_subnet_v2.terraform_management_network_sub1"]
  security_groups = ["${openstack_networking_secgroup_v2.terraform_local_secgroup.name}"]
  block_device{
    source_type = "image"
    uuid        = "${openstack_images_image_v2.terraform_upstream_image.id}"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 10
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 500
    boot_index = -1
  }

  network {
    name = "${var.infraName}_deploy_network"
  }
  network {
    name = "${var.infraName}_management_network"
  }
}

resource "openstack_compute_instance_v2" "terraform_compute_instance" {
  count           = "${var.nbComputeNodes}"
  name            = "${var.infraName}_compute-${format("%02d", count.index +1)}_instance"
  flavor_id       = "${data.openstack_compute_flavor_v2.terraform_compute_flavor.id}"
  key_pair        = "${openstack_compute_keypair_v2.terraform-keypair.id}"
  depends_on      = ["openstack_networking_router_v2.terraform_deploy_router",
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1",
    "openstack_networking_subnet_v2.terraform_management_network_sub1",
    "openstack_networking_subnet_v2.terraform_tunnel_network_sub1",
    "openstack_networking_subnet_v2.terraform_storage_network_sub1"]
  security_groups = ["${openstack_networking_secgroup_v2.terraform_local_secgroup.name}"]
  block_device{
    source_type = "image"
    uuid        = "${openstack_images_image_v2.terraform_upstream_image.id}"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 10
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 500
    boot_index = -1
  }

  network {
    name = "${var.infraName}_deploy_network"
  }
  network {
    name = "${var.infraName}_management_network"
  }
  network {
    name = "${var.infraName}_tunnel_network"
  }
  network {
    name = "${var.infraName}_storage_network"
  }
}

resource "openstack_compute_instance_v2" "terraform_storage_instance" {
  count           = "${var.nbStorageNodes}"
  name            = "${var.infraName}_storage-${format("%02d", count.index +1)}_instance"
  flavor_id       = "${data.openstack_compute_flavor_v2.terraform_storage_flavor.id}"
  key_pair        = "${openstack_compute_keypair_v2.terraform-keypair.id}"
  depends_on      = ["openstack_networking_router_v2.terraform_deploy_router",
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1",
    "openstack_networking_subnet_v2.terraform_management_network_sub1",
    "openstack_networking_subnet_v2.terraform_tunnel_network_sub1",
    "openstack_networking_subnet_v2.terraform_storage_network_sub1"]
  security_groups = ["${openstack_networking_secgroup_v2.terraform_local_secgroup.name}"]
  block_device{
    source_type = "image"
    uuid        = "${openstack_images_image_v2.terraform_upstream_image.id}"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 10
  }
  block_device{
    count = "2"
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }
  block_device{
    source_type = "blank"
    delete_on_termination = true
    destination_type = "volume"
    volume_size = 100
    boot_index = -1
  }

  network {
    name = "${var.infraName}_deploy_network"
  }
  network {
    name = "${var.infraName}_management_network"
  }
  network {
    name = "${var.infraName}_tunnel_network"
  }
  network {
    name = "${var.infraName}_storage_network"
  }
}
