resource "null_resource" "terraform_osa_provisioner" {
  connection {
    type        = "ssh"
    user        = "${var.operatingSystem}"
    host        = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
    private_key = "${file("AdminKey.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chown ${var.operatingSystem}:${var.operatingSystem} /opt/terraform",
    ]
  }

  provisioner "file" {
    content     = "${data.template_file.ansibleInventory.rendered}"
    destination = "/opt/terraform/tf.inventory"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /opt/openstack-ansible",
      "sudo git clone -b 18.1.1 https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible",
      "sudo sh -c 'cd /opt/openstack-ansible && scripts/bootstrap-ansible.sh'",
    ]
  }

  depends_on = ["openstack_compute_instance_v2.terraform_deploy_instance"]
}
