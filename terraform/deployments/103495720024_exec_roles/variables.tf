variable "environment" {
  type        = string
  description = "One of [ production | staging | demo ]"
  default     = "staging"
}

variable "splunk_config_bucket" {
  description = "Name of the target bucket for retriving config."
  type        = string
  default     = "cdio-cyber-security-splunk-apps-publishing-test"
}

variable "splunk_forwarder_name" {
  description = "Name used to derive a role ARN and path prefix for S3."
  type        = string
  default     = "co-cdio-technology-official-it-platform-wec"
}