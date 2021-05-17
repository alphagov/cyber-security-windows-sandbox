resource "aws_secretsmanager_secret" "ssh_keypair" {
  name       = var.public_key_name
}

resource "aws_secretsmanager_secret_version" "ssh_keypair" {
  secret_id     = aws_secretsmanager_secret.ssh_keypair.id
  secret_string = jsonencode({
    private = file(var.private_key_path)
    public  = file(var.public_key_path)
  })
}

resource "aws_key_pair" "auth" {
  key_name   = var.public_key_name
  public_key = file(var.public_key_path)
}
