output "BuildReport" {
  value = data.template_file.reportHead.rendered
}

output "DeployNode" {
  value = data.template_file.reportDeploy.rendered
}

output "WebNodes" {
  value = join("", data.template_file.reportWeb.*.rendered)
}

output "DBNodes" {
  value = join("", data.template_file.reportDB.*.rendered)
}

output "DeployUserData" {
  value = format("\n%s", data.template_file.cloud-init-deploy.rendered)
}

output "NodeUserData" {
  value = format("\n%s", data.template_file.cloud-init-node.rendered)
}

