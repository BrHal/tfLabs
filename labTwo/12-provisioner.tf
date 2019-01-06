resource "null_resource" "terraform_osa_ubuntu_provisioner" {
  count = "${var.operatingSystem == "ubuntu" ? 1 : 0}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
      private_key = "${file("AdminKey.pem")}"
    }

    inline = [
      "sudo rm -rf /opt/openstack-ansible",
      "sudo git clone -b 18.1.1 https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible",
      "sudo sh -c 'cd /opt/openstack-ansible && scripts/bootstrap-ansible.sh'",
    ]
  }

  depends_on = ["openstack_compute_instance_v2.terraform_deploy_instance"]
}

resource "null_resource" "terraform_osa_centos_provisioner" {
  count = "${var.operatingSystem == "centos" ? 1 : 0}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "centos"
      host        = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
      private_key = "${file("AdminKey.pem")}"
    }

    inline = [
      "sudo rm -rf /opt/openstack-ansible",
      "sudo git clone -b 18.1.1 https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible",
      "sudo sh -c 'cd /opt/openstack-ansible && scripts/bootstrap-ansible.sh'",
    ]
  }

  depends_on = ["openstack_compute_instance_v2.terraform_deploy_instance"]
}
