resource "null_resource" "terraform_provisioner1" {
  count = "${var.ansibleManaged ? 1 : 0}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = "${openstack_networking_floatingip_v2.terraform_floatip.address}"
      private_key = "${file("BHaKP1.pem")}"
    }

    inline = [
      "sudo apt-get -qq update",
      "sudo apt-get -qq install python",
    ]
  }

  depends_on = ["openstack_compute_instance_v2.terraform_main_instance"]
}
