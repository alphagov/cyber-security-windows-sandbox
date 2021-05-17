resource "null_resource" "ssh-keypair" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/Local/create_keypair.sh ${var.ssh_path} ${var.public_key_name}"
    interpreter = ["bash"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "winssh"
  public_key = file(var.public_key_path)
}
