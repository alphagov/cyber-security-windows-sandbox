locals {
  tags = {
    Service       = "windows-sandbox"
    Environment   = var.environment
    SvcOwner      = "Cyber"
    DeployedUsing = "Terraform"
    SvcCodeURL    = "https://github.com/alphagov/cyber-security-terraform"
  }

  env_variables   = {
    "environment": var.environment
  }


  user_data_ps1    = file("${path.module}/scripts/WinRM/user_data.ps1")
  user_data        = <<END
<powershell>
# add env vars
$profile_set_env_vars = @"
%{ for var_name, value in local.env_variables }
`$env:${var_name} = `"${value}`"
%{ endfor }
"@

Try {
  If (Test-Path $profile) {
    Write-Host "Profile already exists"
  }
} Catch {
  New-Item $profile
  Write-Host "Creating empty default profile"
}
Add-Content $profile $profile_set_env_vars

${local.user_data_ps1}
</powershell>
END
}
