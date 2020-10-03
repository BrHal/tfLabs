data "openstack_compute_flavor_v2" "terraform_best_flavor" {
  name = var.flavorName
}

data "openstack_networking_network_v2" "terraform_external_network" {
  name = var.publicNetwork
}

data "template_file" "workers" {
  count = var.nbWorkers

  template = <<EOF
$${hostIP} $${hostName}
EOF

  vars = {
    hostName = format("worker%02d",  count.index + 1)
    hostIP = cidrhost(var.worker_CIDR, count.index + 11)
  }
}

