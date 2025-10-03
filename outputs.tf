output "akamai_group_ID" {
  description = "akamai group ID"
  value = data.akamai_group.my_group_id
}

output "akamai_appsec_ID" {
  description = "akamai sec config ID"
  value = data.akamai_appsec_configuration.my_configuration.id
}

output "akamai_property_ID" {
  description = "akamai property config ID"
  value = data.akamai_property.my_property.id
}