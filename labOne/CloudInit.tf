data "template_file" "cloud-init-node" {
  template = file("cloud-init-${var.operatingSystem}-node.tpl.yml")

  vars = {
    cloud          = var.cloud
    ansiblePrivKey = file("AnsibleKey.pem.b64")
    keyOwner       = "${var.operatingSystem}:${var.operatingSystem}"
    ansiblePubKey  = file("AnsibleKey.pub")
    hosts          = "\n    ${join("    ", data.template_file.workers.*.rendered)}"
  }
}

data "template_file" "cloud-init-worker" {
  template = file("cloud-init-${var.operatingSystem}-worker.tpl.yml")

  vars = {
    cloud          = var.cloud
    ansiblePrivKey = file("AnsibleKey.pem.b64")
    keyOwner       = "${var.operatingSystem}:${var.operatingSystem}"
    ansiblePubKey  = file("AnsibleKey.pub")
    hosts          = "\n    ${join("    ", data.template_file.workers.*.rendered)}"
  }
}
