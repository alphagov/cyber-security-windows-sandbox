locals {
  tags = {
    Service       = "windows-sandbox"
    Environment   = var.environment
    SvcOwner      = "Cyber"
    DeployedUsing = "Terraform"
    SvcCodeURL    = "https://github.com/alphagov/cyber-security-windows-sandbox"
  }

  env_variables = {
    "environment" : var.environment,
    "splunk_forwarder_name" : var.splunk_forwarder_name,
    "splunk_config_bucket" : var.splunk_config_bucket,
    "s3_host_account_id" : data.aws_caller_identity.current.account_id,
    "splunk_password": random_password.splunk_admin_password.result,
    "domain": var.domain_name
  }

  user_data_ps1 = file("${path.module}/scripts/WinRM/user_data.ps1")
  user_data     = <<END
<powershell>
${local.user_data_ps1}

# add env vars
$profile_set_env_vars = @"
# setting local environment variables
%{for var_name, value in local.env_variables}
`$env:${var_name} = `"${value}`"
%{endfor}
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

</powershell>
END
}
