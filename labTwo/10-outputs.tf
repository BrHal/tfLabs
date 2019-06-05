output "BuildReport" {
  value = data.template_file.reportHead.rendered
}

output "DeployNode" {
  value = data.template_file.reportDeploy.rendered
}

output "InfraNodes" {
  value = join("", data.template_file.reportInfra.*.rendered)
}

output "ComputeNodes" {
  value = join("", data.template_file.reportCompute.*.rendered)
}

output "StorageNodes" {
  value = join("", data.template_file.reportStorage.*.rendered)
}

output "LogNodes" {
  value = join("", data.template_file.reportLog.*.rendered)
}

output "DeployUserData" {
  value = format("\n%s", data.template_file.cloud-init-deploy.rendered)
}

output "NodeUserData" {
  value = format("\n%s", data.template_file.cloud-init-node.rendered)
}

