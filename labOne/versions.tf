terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "2.1.2"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.32.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.1.2"
    }
  }
  required_version = ">= 0.13"
}
