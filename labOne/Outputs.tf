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

output "WorkerPorts" {
  value= {
    for x, port in openstack_networking_port_v2.terraform_worker_port :
         format("port%02d",x+1) => port.all_fixed_ips
  }
}

