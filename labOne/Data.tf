data "openstack_compute_flavor_v2" "terraform_best_flavor" {
  name = var.flavorName
}

data "openstack_networking_network_v2" "terraform_external_network" {
  name = var.publicNetwork
}

data "template_file" "hosts_internal" {
  count = var.nbWorkers

  template = <<EOF
$${hostIPInternal} $${hostNameInternal}
EOF

  vars = {
    hostNameInternal = format("worker%02d.internal.%s", count.index + 1, var.infraName)
    hostIPInternal   = cidrhost(var.internal_CIDR, count.index + 11)
  }
}

data "template_file" "hosts_gw" {
  count = var.nbWorkers

  template = <<EOF
$${hostIPWorker} $${hostNameWorker}
EOF

  vars = {
    hostNameWorker   = format("worker%02d.worker.%s",  count.index + 1, var.infraName)
    hostIPWorker     = cidrhost(var.worker_CIDR, count.index + 11)
  }
}
