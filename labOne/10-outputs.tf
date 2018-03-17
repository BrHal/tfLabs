output "PublicIP" {
  value = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
}

output "Flavor" {
  value = "${data.openstack_compute_flavor_v2.terraform_best_flavor.name}"
}

output "vCPUs" {
  value = "${data.openstack_compute_flavor_v2.terraform_best_flavor.vcpus}"
}

output "RAM (Mo)" {
  value = "${data.openstack_compute_flavor_v2.terraform_best_flavor.ram}"
}

output "Disk (Go)" {
  value = "${data.openstack_compute_flavor_v2.terraform_best_flavor.disk}"
}
