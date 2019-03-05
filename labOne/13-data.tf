data "openstack_networking_network_v2" "terraform_external_network" {
  name = "${var.publicNetwork}"
}

data "openstack_compute_flavor_v2" "terraform_best_flavor" {
  ram      = 4096
  min_disk = 20
  vcpus    = 2
}
