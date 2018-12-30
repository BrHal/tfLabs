data "openstack_networking_network_v2" "terraform_external_network" {
  name = "${var.publicNetwork}"
}

data "openstack_compute_flavor_v2" "terraform_deploy_flavor" {
  name = "tf.04V.04G.0G"
}

data "openstack_compute_flavor_v2" "terraform_infra_flavor" {
  name = "tf.04V.08G.0G"
}

data "openstack_compute_flavor_v2" "terraform_log_flavor" {
  name = "tf.04V.08G.0G"
}

data "openstack_compute_flavor_v2" "terraform_compute_flavor" {
  name = "tf.16V.64G.0G"
}

data "openstack_compute_flavor_v2" "terraform_storage_flavor" {
  name = "tf.04V.08G.0G"
}

data "template_file" "reportHead" {
  template = <<EOF

Cloud :
 ${var.cloud}
OS :
 Built from $${buildType} image $${imageRef}
Login :
 ssh [ -i <yourPrivateKey> ] ${var.operatingSystem}@${openstack_networking_floatingip_v2.terraform_floatip.address}
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
    netDeployIP = "${openstack_compute_instance_v2.terraform_deploy_instance.network.0.fixed_ip_v4}"
  }
}

data "template_file" "reportInfra" {
  # Render the template once for each instance
  count    = "${var.nbInfraNodes}"
  template = <<EOF

    Host : $${hostName}
    Flavor : $${flavorName}
    Deploy network : $${netDeployName} / $${netDeployIP}
    Management network : $${netManagementName} / $${netManagementIP}
    Tunnel network : $${netTunnelName} / $${netTunnelIP}
EOF
  vars {
    hostName = "${openstack_compute_instance_v2.terraform_infra_instance.*.name[count.index]}"
    flavorName = "${openstack_compute_instance_v2.terraform_infra_instance.*.flavor_name[count.index]}"
    netDeployName = "${openstack_compute_instance_v2.terraform_infra_instance.*.network.0.name[count.index]}"
    netDeployIP = "${openstack_compute_instance_v2.terraform_infra_instance.*.network.0.fixed_ip_v4[count.index]}"
    netManagementName = "${openstack_compute_instance_v2.terraform_infra_instance.*.network.1.name[count.index]}"
    netManagementIP = "${openstack_compute_instance_v2.terraform_infra_instance.*.network.1.fixed_ip_v4[count.index]}"
    netTunnelName = "${openstack_compute_instance_v2.terraform_infra_instance.*.network.2.name[count.index]}"
    netTunnelIP = "${openstack_compute_instance_v2.terraform_infra_instance.*.network.2.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "reportCompute" {
  # Render the template once for each instance
  count    = "${var.nbComputeNodes}"
  template = <<EOF

    Host : $${hostName}
    Flavor : $${flavorName}
    Deploy network : $${netDeployName} / $${netDeployIP}
    Management network : $${netManagementName} / $${netManagementIP}
    Tunnel network : $${netTunnelName} / $${netTunnelIP}
    Storage network : $${netStorageName} / $${netStorageIP}
EOF
  vars {
    hostName = "${openstack_compute_instance_v2.terraform_compute_instance.*.name[count.index]}"
    flavorName = "${openstack_compute_instance_v2.terraform_compute_instance.*.flavor_name[count.index]}"
    netDeployName = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.0.name[count.index]}"
    netDeployIP = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.0.fixed_ip_v4[count.index]}"
    netManagementName = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.1.name[count.index]}"
    netManagementIP = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.1.fixed_ip_v4[count.index]}"
    netTunnelName = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.2.name[count.index]}"
    netTunnelIP = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.2.fixed_ip_v4[count.index]}"
    netStorageName = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.3.name[count.index]}"
    netStorageIP = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.3.fixed_ip_v4[count.index]}"
  }
}
data "template_file" "reportStorage" {
  # Render the template once for each instance
  count    = "${var.nbStorageNodes}"
  template = <<EOF

    Host : $${hostName}
    Flavor : $${flavorName}
    Deploy network : $${netDeployName} / $${netDeployIP}
    Management network : $${netManagementName} / $${netManagementIP}
    Tunnel network : $${netTunnelName} / $${netTunnelIP}
    Storage network : $${netStorageName} / $${netStorageIP}
EOF
  vars {
    hostName = "${openstack_compute_instance_v2.terraform_storage_instance.*.name[count.index]}"
    flavorName = "${openstack_compute_instance_v2.terraform_storage_instance.*.flavor_name[count.index]}"
    netDeployName = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.0.name[count.index]}"
    netDeployIP = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.0.fixed_ip_v4[count.index]}"
    netManagementName = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.1.name[count.index]}"
    netManagementIP = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.1.fixed_ip_v4[count.index]}"
    netTunnelName = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.2.name[count.index]}"
    netTunnelIP = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.2.fixed_ip_v4[count.index]}"
    netStorageName = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.3.name[count.index]}"
    netStorageIP = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.3.fixed_ip_v4[count.index]}"
  }
}
data "template_file" "reportLog" {
  # Render the template once for each instance
  count    = "${var.nbLogNodes}"
  template = <<EOF

    Host : $${hostName}
    Flavor : $${flavorName}
    Deploy network : $${netDeployName} / $${netDeployIP}
    Management network : $${netManagementName} / $${netManagementIP}
EOF
  vars {
    hostName = "${openstack_compute_instance_v2.terraform_log_instance.*.name[count.index]}"
    flavorName = "${openstack_compute_instance_v2.terraform_log_instance.*.flavor_name[count.index]}"
    netDeployName = "${openstack_compute_instance_v2.terraform_log_instance.*.network.0.name[count.index]}"
    netDeployIP = "${openstack_compute_instance_v2.terraform_log_instance.*.network.0.fixed_ip_v4[count.index]}"
    netManagementName = "${openstack_compute_instance_v2.terraform_log_instance.*.network.1.name[count.index]}"
    netManagementIP = "${openstack_compute_instance_v2.terraform_log_instance.*.network.1.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "hostvarsDeploy" {
  template = <<EOF
$${hostIP} $${hostName}
EOF
  vars{
    hostName = "${openstack_compute_instance_v2.terraform_deploy_instance.name}"
    hostIP = "${openstack_compute_instance_v2.terraform_deploy_instance.network.0.fixed_ip_v4}"
  }
}

data "template_file" "hostvarsInfra" {
  count = "${var.nbInfraNodes}"
  template = <<EOF
$${hostIP} $${hostName}
EOF
  vars{
    hostName = "${openstack_compute_instance_v2.terraform_infra_instance.*.name[count.index]}"
    hostIP = "${openstack_compute_instance_v2.terraform_infra_instance.*.network.0.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "hostvarsCompute" {
  count = "${var.nbComputeNodes}"
  template = <<EOF
$${hostIP} $${hostName}
EOF
  vars{
    hostName = "${openstack_compute_instance_v2.terraform_compute_instance.*.name[count.index]}"
    hostIP = "${openstack_compute_instance_v2.terraform_compute_instance.*.network.0.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "hostvarsStorage" {
  count = "${var.nbStorageNodes}"
  template = <<EOF
$${hostIP} $${hostName}
EOF
  vars{
    hostName = "${openstack_compute_instance_v2.terraform_storage_instance.*.name[count.index]}"
    hostIP = "${openstack_compute_instance_v2.terraform_storage_instance.*.network.0.fixed_ip_v4[count.index]}"
  }
}

data "template_file" "hostvarsLog" {
  count = "${var.nbLogNodes}"
  template = <<EOF
$${hostIP} $${hostName}
EOF
  vars{
    hostName = "${openstack_compute_instance_v2.terraform_log_instance.*.name[count.index]}"
    hostIP = "${openstack_compute_instance_v2.terraform_log_instance.*.network.0.fixed_ip_v4[count.index]}"
  }
}
