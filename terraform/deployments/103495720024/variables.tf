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

variable "domain_name" {
  description = ""
  type        = string
  default     = "shire.com"
}
