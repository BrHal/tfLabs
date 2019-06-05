data "template_file" "cloud-init-deploy" {
  template = file("cloud-init-${var.operatingSystem}-deploy.tpl.yml")

  vars = {
    info = "\n    ${join(
      "    ",
      concat(
        data.template_file.reportInfra.*.rendered,
        data.template_file.reportCompute.*.rendered,
        data.template_file.reportStorage.*.rendered,
        data.template_file.reportLog.*.rendered,
      ),
    )}"
    hosts = "\n    ${join(
      "    ",
      concat(
        data.template_file.hostvarsInfra.*.rendered,
        data.template_file.hostvarsCompute.*.rendered,
        data.template_file.hostvarsStorage.*.rendered,
        data.template_file.hostvarsLog.*.rendered,
      ),
    )}"
    buildType      = var.useTenantImage ? "tenant" : "upstream"
    imageRef       = var.useTenantImage ? var.imageNames[var.operatingSystem] : var.imageURLs[var.operatingSystem]
    cloud          = var.cloud
    ansiblePrivKey = file("AnsibleKey.pem.b64")
    keyOwner       = "${var.operatingSystem}:${var.operatingSystem}"
    ansiblePubKey  = file("AnsibleKey.pub")
  }
}

data "template_file" "cloud-init-node" {
  template = file("cloud-init-${var.operatingSystem}-node.tpl.yml")

  vars = {
    ansiblePubKey = file("AnsibleKey.pub")
  }
}

