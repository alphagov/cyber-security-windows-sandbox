resource "aws_ssm_parameter" "windows_dc_admin_password" {
  name        = "/windows-sandbox/dc/administrator/password"
  description = "Password for local windows DC Administrator"
  type        = "SecureString"
  value       = try(rsadecrypt(aws_instance.dc.password_data,file(var.private_key_path)), "missing")
  overwrite   = true
  tags = merge(local.tags, { "Name" : "/windows-sandbox/administrator/password" })
}

resource "aws_ssm_parameter" "windows_wec_admin_password" {
  name        = "/windows-sandbox/wec/administrator/password"
  description = "Password for local windows WEC Administrator"
  type        = "SecureString"
  value       = try(rsadecrypt(aws_instance.wec.password_data,file(var.private_key_path)), "missing")
  overwrite   = true
  tags = merge(local.tags, { "Name" : "/windows-sandbox/administrator/password" })
}

resource "random_password" "splunk_admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_ssm_parameter" "windows_wec_splunk_password" {
  name        = "/windows-sandbox/wec/splunk/password"
  description = "Password for local windows WEC Splunk admin password"
  type        = "SecureString"
  value       = random_password.splunk_admin_password.result
  overwrite   = true
  tags = merge(local.tags, { "Name" : "/windows-sandbox/wec/splunk/password" })
}

resource "random_password" "domain_admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_ssm_parameter" "windows_domain_admin_password" {
  name        = "/windows-sandbox/domain/admin/password"
  description = "Password for local windows domain admin password"
  type        = "SecureString"
  value       = random_password.domain_admin_password.result
  overwrite   = true
  tags = merge(local.tags, { "Name" : "/windows-sandbox/domain/admin/password" })
}