data "openstack_networking_network_v2" "terraform_external_network" {
  name = "${var.publicNetwork}"
}

data "openstack_compute_flavor_v2" "terraform_deploy_flavor" {
  name = "${var.DeployNodeFlavor}"
}

data "openstack_compute_flavor_v2" "terraform_web_flavor" {
  name = "${var.WebNodeFlavor}"
}

data "openstack_compute_flavor_v2" "terraform_db_flavor" {
  name = "${var.DBNodeFlavor}"
}

data "template_file" "reportHead" {
  template = <<EOF

Cloud :
 ${var.cloud}
OS :
 Built from $${buildType} image $${imageRef}
Login :
 ssh [ -i <yourPrivateKey> ] ${var.operatingSystem}@${openstack_networking_floatingip_v2.terraform_floatip.address}
Public LoadBalancer FIP : ${openstack_networking_floatingip_v2.terraform_lb_floatip.address}
EOF

  vars {
    buildType = "${var.useTenantImage ? "tenant" : "upstream"}"

    imageRef = "${var.useTenantImage ?
       var.imageNames["${var.operatingSystem}"]
        :
       var.imageURLs["${var.operatingSystem}"]
        }"
  }
}

data "template_file" "reportDeploy" {
  template = <<EOF

    Host : ${openstack_compute_instance_v2.terraform_deploy_instance.name}
    Flavor : ${openstack_compute_instance_v2.terraform_deploy_instance.flavor_name}
    Deploy network : $${netDeployName} / $${netDeployIP}
EOF

  vars {
    netDeployName = "${openstack_compute_instance_v2.terraform_deploy_instance.network.0.name}"
    netDeployIP   = "${openstack_compute_instance_v2.terraform_deploy_instance.network.0.fixed_ip_v4}"
  }
}

data "template_file" "reportWeb" {
  # Render the template once for each instance
  count = "${var.nbWebNodes}"

  template = <<EOF

    Host : $${hostName}
    Flavor : $${flavorName}
    Deploy network : $${netDeployName} / $${netDeployIP}
    Ext1 network : $${netExt1Name} / $${netExt1IP}
    int1 network : $${netint1Name} / $${netint1IP}
EOF

  vars {
    hostName      = "${openstack_compute_instance_v2.terraform_web_instance.*.name[count.index]}"
    flavorName    = "${openstack_compute_instance_v2.terraform_web_instance.*.flavor_name[count.index]}"
    netDeployName = "${openstack_compute_instance_v2.terraform_web_instance.*.network.0.name[count.index]}"
    netDeployIP   = "${openstack_compute_instance_v2.terraform_web_instance.*.network.0.fixed_ip_v4[count.index]}"
    netExt1Name   = "${openstack_compute_instance_v2.terraform_web_instance.*.network.1.name[count.index]}"
    netExt1IP     = "${openstack_compute_instance_v2.terraform_web_instance.*.network.1.fixed_ip_v4[count.index]}"
    netint1Name   = "${openstack_compute_instance_v2.terraform_web_instance.*.network.2.name[count.index]}"
    netint1IP     = "${openstack_compute_instance_v2.terraform_web_instance.*.network.2.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "reportDB" {
  # Render the template once for each instance
  count = "${var.nbDBNodes}"

  template = <<EOF

    Host : $${hostName}
    Flavor : $${flavorName}
    Deploy network : $${netDeployName} / $${netDeployIP}
    int1 network : $${netint1Name} / $${netint1IP}
EOF

  vars {
    hostName      = "${openstack_compute_instance_v2.terraform_db_instance.*.name[count.index]}"
    flavorName    = "${openstack_compute_instance_v2.terraform_db_instance.*.flavor_name[count.index]}"
    netDeployName = "${openstack_compute_instance_v2.terraform_db_instance.*.network.0.name[count.index]}"
    netDeployIP   = "${openstack_compute_instance_v2.terraform_db_instance.*.network.0.fixed_ip_v4[count.index]}"
    netint1Name   = "${openstack_compute_instance_v2.terraform_db_instance.*.network.1.name[count.index]}"
    netint1IP     = "${openstack_compute_instance_v2.terraform_db_instance.*.network.1.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "hostvarsDeploy" {
  template = <<EOF
$${hostIP} $${hostName}
EOF

  vars {
    hostName = "${openstack_compute_instance_v2.terraform_deploy_instance.name}"
    hostIP   = "${openstack_compute_instance_v2.terraform_deploy_instance.network.0.fixed_ip_v4}"
  }
}

data "template_file" "hostvarsWeb" {
  count = "${var.nbWebNodes}"

  template = <<EOF
$${hostIP} $${hostName}
EOF

  vars {
    hostName = "${openstack_compute_instance_v2.terraform_web_instance.*.name[count.index]}"
    hostIP   = "${openstack_compute_instance_v2.terraform_web_instance.*.network.0.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "hostvarsDB" {
  count = "${var.nbDBNodes}"

  template = <<EOF
$${hostIP} $${hostName}
EOF

  vars {
    hostName = "${openstack_compute_instance_v2.terraform_db_instance.*.name[count.index]}"
    hostIP   = "${openstack_compute_instance_v2.terraform_db_instance.*.network.0.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "ansibleInventory" {
  template = <<EOF
[web_hosts]
$${webHostVars}
[DB_hosts]
$${DBHostVars}
EOF

  vars {
    webHostVars = "${join("\n",formatlist("%s VLAN_WEB_IP=%s VLAN_DB_IP=%s",
      openstack_compute_instance_v2.terraform_web_instance.*.name,
      openstack_compute_instance_v2.terraform_web_instance.*.network.1.fixed_ip_v4,
      openstack_compute_instance_v2.terraform_web_instance.*.network.2.fixed_ip_v4))}"

    DBHostVars = "${join("\n",formatlist("%s VLAN_DB_IP=%s",
      openstack_compute_instance_v2.terraform_db_instance.*.name,
      openstack_compute_instance_v2.terraform_db_instance.*.network.1.fixed_ip_v4))}"
  }
}
