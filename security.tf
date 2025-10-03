#resource sec config
resource "akamai_appsec_configuration" "sec_configuration" {
  name        = "cearia_sec_config"
  description = "This is my new configuration."
  contract_id = "1-5C13O2"
  group_id    = "299415"
  host_names  = ["cearia-scriptclub.test.edgekey.net"]
}

// Create new with default settings
resource "akamai_appsec_security_policy" "my-security-policy" {
  config_id              = akamai_appsec_configuration.sec_configuration.config_id
  default_settings       = true
  security_policy_name   = "my-policy"
  security_policy_prefix = "ce77"
}

// Create new with default settings
resource "akamai_appsec_security_policy" "security-policy-2" {
  config_id              = akamai_appsec_configuration.sec_configuration.config_id
  default_settings       = true
  security_policy_name   = "second-policy"
  security_policy_prefix = "77ce"
}
