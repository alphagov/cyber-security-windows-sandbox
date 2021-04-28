variable "environment" {
  type        = string
  description = "One of [ production | staging | demo ]"
}

//variable "profile" {
//  default = "terraform"
//}

//variable "availability_zone" {
//  description = "https://www.terraform.io/docs/providers/aws/d/availability_zone.html"
//  default     = ""
//}

//variable "shared_credentials_file" {
//  description = "Path to your AWS credentials file"
//  type        = string
//  default     = "~/.aws/credentials"
//}
//
//variable "public_key_name" {
//  description = "A name for AWS Keypair to use to auth to helk. Can be anything you specify."
//  default     = "linux"
//}
//
//variable "public_key_path" {
//  description = "Path to the public key to be loaded into the helk authorized_keys file"
//  type        = string
//  default     = "~/.ssh/linux.pub"
//}
//variable "private_key_path" {
//  description = "Path to the private key to use to authenticate to helk."
//  type        = string
//  default     = "~/.ssh/linux"
//}

variable "ip_whitelist" {
  description = "A list of CIDRs that will be allowed to access the EC2 instances"
  type        = list(string)
  default     = [""]
}

variable "external_dns_servers" {
  description = "Configure lab to allow external DNS resolution"
  type        = list(string)
  default     = ["8.8.8.8"]
}

# If you are building your own AMIs you will have replace these values below with your own AMIs.
# This will also have to be changed if you choose to be in another region besides 'us-west-1'