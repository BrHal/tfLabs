locals {
  imageId = "${var.useTenantImage ?
      data.openstack_images_image_v2.terraform_tenant_image.id
      :
      openstack_images_image_v2.terraform_upstream_image.id}"
}

resource "openstack_compute_instance_v2" "terraform_deploy_instance" {
  name         = "${var.infraName}-deploy"
  flavor_id    = "${data.openstack_compute_flavor_v2.terraform_deploy_flavor.id}"
  key_pair     = "${openstack_compute_keypair_v2.terraform-admin-keypair.id}"
  image_id     = "${local.imageId}"
  config_drive = true

  depends_on = ["openstack_networking_router_v2.terraform_deploy_router",
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1",
  ]

  security_groups = ["${openstack_networking_secgroup_v2.terraform_remote_secgroup.name}",
    "${openstack_networking_secgroup_v2.terraform_local_secgroup.name}",
  ]

  network {
    name = "${var.infraName}_deploy_network"
  }

  user_data = "${data.template_file.cloud-init-deploy.rendered}"
}

resource "openstack_compute_instance_v2" "terraform_web_instance" {
  count        = "${var.nbWebNodes}"
  name         = "${var.infraName}-web-${format("%02d", count.index +1)}"
  flavor_id    = "${data.openstack_compute_flavor_v2.terraform_web_flavor.id}"
  key_pair     = "${openstack_compute_keypair_v2.terraform-ansible-keypair.id}"
  image_id     = "${local.imageId}"
  config_drive = true

  depends_on = [
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1",
    "openstack_networking_subnet_v2.terraform_ext1_network_sub1",
    "openstack_networking_subnet_v2.terraform_int1_network_sub1",
  ]

  security_groups = ["${openstack_networking_secgroup_v2.terraform_remote_secgroup.name}",
    "${openstack_networking_secgroup_v2.terraform_local_secgroup.name}",
    "${openstack_networking_secgroup_v2.terraform_ext_poolmember_secgroup.name}",
  ]

  network {
    name = "${var.infraName}_deploy_network"
  }

  network {
    name = "${var.infraName}_ext1_network"
  }

  network {
    name = "${var.infraName}_int1_network"
  }

  user_data = "${data.template_file.cloud-init-node.rendered}"
}

resource "openstack_compute_instance_v2" "terraform_db_instance" {
  count        = "${var.nbDBNodes}"
  name         = "${var.infraName}-db-${format("%02d", count.index +1)}"
  flavor_id    = "${data.openstack_compute_flavor_v2.terraform_db_flavor.id}"
  key_pair     = "${openstack_compute_keypair_v2.terraform-ansible-keypair.id}"
  image_id     = "${local.imageId}"
  config_drive = true

  depends_on = [
    "openstack_networking_subnet_v2.terraform_deploy_network_sub1",
    "openstack_networking_subnet_v2.terraform_int1_network_sub1",
  ]

  security_groups = ["${openstack_networking_secgroup_v2.terraform_local_secgroup.name}"]

  network {
    name = "${var.infraName}_deploy_network"
  }

  network {
    name = "${var.infraName}_int1_network"
  }

  user_data = "${data.template_file.cloud-init-node.rendered}"
}
