output "PublicIP" {
  value = openstack_networking_floatingip_v2.terraform_floatip.address
}

output "Flavor" {
  value = data.openstack_compute_flavor_v2.terraform_best_flavor.name
}

output "vCPUs" {
  value = data.openstack_compute_flavor_v2.terraform_best_flavor.vcpus
}

output "RAM" {
  value = data.openstack_compute_flavor_v2.terraform_best_flavor.ram
}

output "Disk" {
  value = data.openstack_compute_flavor_v2.terraform_best_flavor.disk
}

output "Workers" {
  value = format("\n %s",join(" ", data.template_file.workers.*.rendered))
}

output "DNSServers" {
  value = format("[ %s ]",join(",",formatlist("'%s'",var.DNSServers)))
}

output "CloudInitGW" {
  value = data.template_file.cloud-init-gw.rendered
}
