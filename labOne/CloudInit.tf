locals{
  hostList ={
      for x, instance in
        openstack_compute_instance_v2.terraform_worker_instance :
           format("worker%02d",x+1) => instance.network.0.fixed_ip_v4
      }
}

data "template_file" "cloud-init-node" {
  template = file("cloud-init-${var.operatingSystem}-node.tpl.yml")

  vars = {
    cloud          = var.cloud
    ansiblePrivKey = file("AnsibleKey.pem.b64")
    keyOwner       = "${var.operatingSystem}:${var.operatingSystem}"
    ansiblePubKey  = file("AnsibleKey.pub")
  }
}
