# ${format("\n    %s",data.template_file.hostvarsDeploy.rendered)}${format("    %s",join("    ",data.template_file.hostvarsInfra.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsCompute.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsStorage.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsLog.*.rendered))}EOF
data "template_file" "hosts"{
  template =<<EOF
${format("\n    %s",join("    ",data.template_file.hostvarsInfra.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsCompute.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsStorage.*.rendered))}${format("    %s",join("    ",data.template_file.hostvarsLog.*.rendered))}
EOF
}

data "template_file" "inventory"{

}

data "template_file" "deploy" {
  template="${file("deploy.tpl.yml")}"
  vars{
    hosts = "${data.template_file.hosts.rendered}"
  }
}
