variable "environment" {
  type        = string
  description = "One of [ production | staging | demo ]"
}

variable "public_key_name" {
  description = "A name for AWS Keypair to use to auth to helk. Can be anything you specify."
  default     = "windows_sandbox_ssh_key"
}

variable "public_key_path" {
  description = "Path to the public key to be loaded into the helk authorized_keys file"
  type        = string
  default     = "~/.ssh/linux.pub"
}

variable "private_key_path" {
  description = "Path to the private key to use to authenticate to helk."
  type        = string
  default     = "~/.ssh/linux"
}

variable "domain_name" {
  description = ""
  type        = string
  default     = "shire.com"
}

variable "ip_allowlist" {
  description = "A list of CIDRs that will be allowed to access the EC2 instances"
  type        = list(string)
  default     = [""]
}

variable "external_dns_servers" {
  description = "Configure lab to allow external DNS resolution"
  type        = list(string)
  default     = ["8.8.8.8"]
}

variable "splunk_config_bucket" {
  description = "Name of the target bucket for retriving config."
  type        = string
}

variable "splunk_forwarder_name" {
  description = "Name used to derive a role ARN and path prefix for S3."
  type        = string
}
# If you are building your own AMIs you will have replace these values below with your own AMIs.
# This will also have to be changed if you choose to be in another region besides 'us-west-1'
