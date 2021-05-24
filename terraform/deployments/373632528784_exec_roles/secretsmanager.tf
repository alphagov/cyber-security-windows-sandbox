resource "aws_secretsmanager_secret" "ssh_key" {
  name = var.ssh_key_name
}
