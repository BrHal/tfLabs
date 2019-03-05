output "1 - Build report :" {
  value = "${data.template_file.reportHead.rendered}"
}

output "2 - Deploy node :" {
  value = "${data.template_file.reportDeploy.rendered}"
}

output "3 - Web nodes :" {
  value = "${join("",data.template_file.reportWeb.*.rendered)}"
}

output "4 - DB nodes :" {
  value = "${join("",data.template_file.reportDB.*.rendered)}"
}

output "991 - deploy user-data" {
  value = "${format("\n%s",data.template_file.cloud-init-deploy.rendered)}"
}

output "992 - node user-data" {
  value = "${format("\n%s",data.template_file.cloud-init-node.rendered)}"
}
