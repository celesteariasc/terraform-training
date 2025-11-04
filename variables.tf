variable "edgerc_path" {
  type        = string
  description = "edgerc_path"
  #default     = "~/.edgerc"
}

variable "config_section" {
  type        = string
  description = "config_section"
  #default     = "terraform"
}

variable "ab_test" {
  type        = string
  description = "ab_test"
  default     = "A"
}

variable "apps" {
  type = list(string)
  description = "Iterations"
}