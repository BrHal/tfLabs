output "1 - Build report :" {
  value ="${data.template_file.reportHead.rendered}"
}

output "2 - Deploy node :" {
  value="${data.template_file.reportDeploy.rendered}"
}

output "3 - Infra nodes :" {
  value="${join("",data.template_file.reportInfra.*.rendered)}"
}

output "4 - Compute nodes :" {
  value="${join("",data.template_file.reportCompute.*.rendered)}"
}

output "5 - Storage nodes :" {
  value="${join("",data.template_file.reportStorage.*.rendered)}"
}

output "6 - Log nodes :" {
  value="${join("",data.template_file.reportLog.*.rendered)}"
}

output "991 - Debug conf"  {
  value = "${format("\n%s",data.template_file.cloud-init-deploy.rendered)}"
}
