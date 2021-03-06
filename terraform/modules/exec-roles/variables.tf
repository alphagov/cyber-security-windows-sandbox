variable "environment" {
  type        = string
  description = "One of [ production | staging | demo ]"
  default     = "staging"
}

variable "splunk_config_account" {
  description = "AWS account ID for the target bucket for retrieving config."
  type        = string
  default     = "103495720024"
}

variable "splunk_config_bucket" {
  description = "Name of the target bucket for retrieving config."
  type        = string
  default     = "cdio-cyber-security-splunk-apps-publishing-test"
}

variable "splunk_forwarder_name" {
  description = "Name used to derive a role ARN and path prefix for S3."
  type        = string
  default     = "co-cdio-technology-official-it-platform-wec"
}

variable "ssh_key_name" {
  description = "A name for AWS Keypair to use to auth to helk. Can be anything you specify."
  default     = "windows_sandbox_ssh_key"
}
