resource "null_resource" "ssh_create_keypair" {
  provisioner "local-exec" {
    command     = "${path.module}/scripts/Local/create_keypair.sh ${var.ssh_path} ${var.public_key_name}"
    interpreter = ["bash"]
  }
}

locals {
  keypair = {
    private = file("${var.ssh_path}/${var.public_key_name}")
    public  = file("${var.ssh_path}/${var.public_key_name}.pub")
  }
}

resource "aws_secretsmanager_secret" "ssh_keypair" {
  name = var.public_key_name
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.ssh_keypair.id
  secret_string = jsonencode(local.keypair)
}

resource "aws_key_pair" "auth" {
  key_name   = var.public_key_name
  public_key = lookup(local.keypair, "public")
}
