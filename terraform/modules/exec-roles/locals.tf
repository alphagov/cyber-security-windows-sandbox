locals {
  tags = {
    Service = "windows-sandbox"
    Environment = var.environment
    SvcOwner = "Cyber"
    DeployedUsing = "Terraform"
    SvcCodeURL = "https://github.com/alphagov/cyber-security-windows-sandbox"
  }
}