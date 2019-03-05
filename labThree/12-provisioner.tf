resource "null_resource" "terraform_osa_provisioner" {
  connection {
    type        = "ssh"
    user        = "${var.operatingSystem}"
    host        = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
    private_key = "${file("AdminKey.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cloud-init status --wait",
      "sudo chown -R ${var.operatingSystem}:${var.operatingSystem} /opt/terraform",
    ]
  }

  provisioner "file" {
    content     = "${data.template_file.ansibleInventory.rendered}"
    destination = "/opt/terraform/tf.inventory"
  }

  depends_on = ["openstack_compute_instance_v2.terraform_deploy_instance"]
}
