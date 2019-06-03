data "openstack_compute_flavor_v2" "terraform_best_flavor" {
  name = var.flavorName
}

