locals {
  tags = {
    Service       = "windows-sandbox"
    Environment   = var.environment
    SvcOwner      = "Cyber"
    DeployedUsing = "Terraform"
    SvcCodeURL    = "https://github.com/alphagov/cyber-security-terraform"
  }

  powershell      = file("${path.module}/scripts/WinRM/user_data.ps1")
  user_data       = "<powershell>\n${local.powershell}\n</powershell>"
}
