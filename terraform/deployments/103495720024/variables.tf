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