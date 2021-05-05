resource "aws_key_pair" "auth" {
  key_name   = "winssh"
  public_key = file(var.public_key_path)
}
