output "PublicIP" {
  value = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
}
