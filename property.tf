resource "akamai_cp_code" "my_cp_code" {
  name        = "cearia Code"
  contract_id = "1-5C13O2"
  group_id    = "299415"
  product_id  = "prd_Fresca"
  timeouts {
    update = "1h"
  }
}

resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = "prd_Fresca"
  contract_id   = "1-5C13O2"
  group_id      = "299415"
  edge_hostname = "cearia-terraform2.com.edgesuite.net"
  ip_behavior   = "IPV4"
  ttl           = 300
  timeouts {
    default = "1h"
  }
}

// Your default rule information
data "akamai_property_rules_builder" "my_default_rule" {
  rules_v2025_04_29 {
    name      = "default"
    is_secure = false
    comments  = <<-EOT
      The behaviors in the default rule apply to all requests for the property hostnames unless another rule overrides these settings.
    EOT
    behavior {
      origin {
        origin_type           = "CUSTOMER"
        hostname              = "script-club-origin-1ovshfqo.fermyon.app"
        forward_host_header   = "ORIGIN_HOSTNAME"
        cache_key_hostname    = "REQUEST_HOST_HEADER"
        compress              = true
        enable_true_client_ip = false
        http_port             = 80
      }
    }
    behavior {
      cp_code {
        value {
          id   = akamai_cp_code.my_cp_code.id
          name = akamai_cp_code.my_cp_code.name
        }
      }
    }
    children = [
      data.akamai_property_rules_builder.compress_text_content.json
    ]
  }
}

// Your child rule information
data "akamai_property_rules_builder" "compress_text_content" {
  rules_v2025_04_29 {
    name                  = "Content Compression"
    criteria_must_satisfy = "all"
    criterion {
      content_type {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        match_wildcard       = true
        values               = ["text/html*", "text/css*", "application/x-javascript*", "text/javascript*", "text/*", "application/javascript", "application/x-javascript", "application/json", "application/x-json", "application/*+json", "application/*+xml", "application/text", "application/vnd.microsoft.icon", "application/vnd-ms-fontobject", "application/x-font-ttf", "application/x-font-opentype", "application/x-font-truetype", "application/xmlfont/eot", "application/xml", "font/opentype", "font/otf", "font/eot", "image/svg+xml", "image/vnd.microsoft.icon", "application/json*", "text/xml*", ]
      }
    }
    behavior {
      gzip_response {
        behavior = "ALWAYS"
      }
    }
  }
} 

resource "akamai_property" "my_property" {
  name          = "cearia_terraformscriptclub"
  product_id    = "prd_Fresca"
  contract_id   = "1-5C13O2"
  group_id      = "299415"
  rule_format   = "v2025-04-29"
  version_notes = "Terraform config"
  rules         = data.akamai_property_rules_builder.my_default_rule.json
  hostnames {
    cname_from             = "cearia-scriptclub.akamaiterraform.com"
    cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
    cert_provisioning_type = "DEFAULT"
  }
}

output "my_default_rule" {
  value = data.akamai_property_rules_builder.my_default_rule
} 