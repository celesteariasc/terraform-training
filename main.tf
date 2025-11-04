#Akamai Group - Get one
data "akamai_group" "my_group_id" {
  group_name  = "Script Club"
  contract_id = "ctr_1-5C13O2"
}

output "my_group_id" {
  value = data.akamai_group.my_group_id.group_name
}

#Security Configuration - Get one
data "akamai_appsec_configuration" "my_configuration" {
  name = "akamaitechday"
}

output "my_appsec_config" {
  value = data.akamai_appsec_configuration.my_configuration.staging_version
}

#Akamai Property
data "akamai_property" "my_property" {
  name    = "cearia-scriptclub"
  version = "2"
}

output "my_property" {
  value = data.akamai_property.my_property.id
}

#locals {
#  notes = join(" - ", ["TF-3001", data.akamai_group.my_group_id])
#} 