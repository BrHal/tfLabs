# ${format("\n    %s",data.template_file.hostvarsDeploy.rendered)}${format("    %s",join("    ",data.template_file.hostvarsInfra.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsCompute.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsStorage.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsLog.*.rendered))}EOF
data "template_file" "cloud-init-deploy" {
  template="${file("cloud-init-deploy.tpl.yml")}"
  vars{
    info = "\n    ${join("    ",
                    concat(data.template_file.reportInfra.*.rendered,
                           data.template_file.reportCompute.*.rendered,
                           data.template_file.reportStorage.*.rendered,
                           data.template_file.reportLog.*.rendered))}"
    hosts = "\n    ${join("    ",
                     concat(data.template_file.hostvarsInfra.*.rendered,
                            data.template_file.hostvarsCompute.*.rendered,
                            data.template_file.hostvarsStorage.*.rendered,
                            data.template_file.hostvarsLog.*.rendered))}"
    buildType = "${var.useTenantImage ? "tenant" : "upstream"}"
    imageRef ="${var.useTenantImage ?
       var.imageNames["${var.operatingSystem}"]
        :
       var.imageURLs["${var.operatingSystem}"]
        }"
    cloud = "${var.cloud}"
  }
}
