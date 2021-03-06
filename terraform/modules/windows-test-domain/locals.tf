locals {
  tags = {
    Service       = "windows-sandbox"
    Environment   = var.environment
    SvcOwner      = "Cyber"
    DeployedUsing = "Terraform"
    SvcCodeURL    = "https://github.com/alphagov/cyber-security-windows-sandbox"
  }

  dc_private_ip  = "172.18.39.5"
  wec_private_ip = "172.18.39.102"

  env_variables = {
    "ENVIRONMENT" : var.environment,
    "FORWARDER" : var.splunk_forwarder_name,
    "BUCKET_NAME" : var.splunk_config_bucket,
    "AWS_ACCOUNT" : var.splunk_config_account,
    "SPLUNK_PASSWORD" : random_password.splunk_admin_password.result,
    "DOMAIN_PASSWORD" : random_password.domain_admin_password.result,
    "DOMAIN" : var.domain_name
    "DOMAIN_CONTROLLER_IP" : local.dc_private_ip
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

`$env:PATHS = `$env:DOMAIN.split(`".`") -replace `"^`", `"DC=`" -join `",`"
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
