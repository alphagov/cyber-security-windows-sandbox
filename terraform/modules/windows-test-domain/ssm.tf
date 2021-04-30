//resource "random_password" "windows_admin_password" {
//  length           = 24
//  special          = true
//  override_special = "_%@"
//}
//
//resource "aws_ssm_parameter" "windows_admin_password" {
//  name        = "/windows-sandbox/administrator/password"
//  description = "Password for local windows sys admin user"
//  type        = "SecureString"
//  value       = random_password.windows_admin_password.result
//  overwrite   = false
//
//  tags = merge(local.tags, { "Name" : "/windows-sandbox/administrator/password" })
//
//}

resource "aws_ssm_parameter" "windows_dc_admin_password" {
  name        = "/windows-sandbox/dc/administrator/password"
  description = "Password for local windows DC Administrator"
  type        = "SecureString"
  value       = rsadecrypt(aws_instance.dc.password_data,file(var.private_key_path))
  overwrite   = true
  tags = merge(local.tags, { "Name" : "/windows-sandbox/administrator/password" })
}

resource "aws_ssm_parameter" "windows_wec_admin_password" {
  name        = "/windows-sandbox/wec/administrator/password"
  description = "Password for local windows WEC Administrator"
  type        = "SecureString"
  value       = rsadecrypt(aws_instance.wec.password_data,file(var.private_key_path))
  overwrite   = true
  tags = merge(local.tags, { "Name" : "/windows-sandbox/administrator/password" })
}