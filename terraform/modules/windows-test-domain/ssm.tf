resource "random_password" "windows_admin_password" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_ssm_parameter" "windows_admin_password" {
  name        = "/windows-sandbox/administrator/password"
  description = "Password for local windows sys admin user"
  type        = "SecureString"
  value       = random_password.windows_admin_password.result
  overwrite   = false

  tags = merge(local.tags, { "Name" : "/windows-sandbox/administrator/password" })

}