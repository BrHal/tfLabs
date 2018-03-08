resource "openstack_compute_instance_v2" "terraform_test_instance" {
name = "${var.infraName}_test_instance"
image_name = "${var.imageName}"
flavor_name = "${var.flavorName}"
key_pair = "${var.keyPair}"
security_groups = ["${openstack_compute_secgroup_v2.terraform_secgroup.name}"]
network {
name = "${var.infraName}_network"
}
}
