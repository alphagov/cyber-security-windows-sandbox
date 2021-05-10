variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-2"
}

variable "environment" {
  type        = string
  description = "One of [ production | staging | demo ]"
  default     = "staging"
}

variable "public_key_name" {
  description = "A name for AWS Keypair to use to auth to helk. Can be anything you specify."
  default     = "win-test-ssh"
}

variable "public_key_path" {
  description = "Path to the public key to be loaded into the helk authorized_keys file"
  type        = string
  default     = "~/.ssh/test-1.pub"
}
variable "private_key_path" {
  description = "Path to the private key to use to authenticate to helk."
  type        = string
  default     = "~/.ssh/test-1"
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