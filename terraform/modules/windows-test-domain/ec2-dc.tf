/*
HFDC1
This process is going to provision from a Pre-Built AMI.
This AMI already has the forest, GPOs, and Users deployed.
*/
resource "aws_instance" "dc" {
  instance_type = "t2.medium"
  ami = data.aws_ami.windows_server_2016_base.image_id

  tags = {
    Name = "HFDC1.${var.domain_name}"
  }

  subnet_id              = aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.windows.id]
  private_ip             = "172.18.39.5"

  key_name               = aws_key_pair.auth.key_name
  get_password_data      = true

  user_data = local.user_data

  provisioner "remote-exec" {
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "winrm"
      user        = "Administrator"
      password    = rsadecrypt(self.password_data,file(var.private_key_path))
      https       = true
      insecure    = true
      port        = 5986

    }
    inline = [
      "powershell Set-ExecutionPolicy Unrestricted -Force",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WinRM\\templating.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\DC\\registry_system_enableula_sacl.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\DC\\registry_terminal_server_sacl.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\DC\\rename_dc_computer.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\DC\\deploy_forest.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\DC\\add_ou.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\DC\\import_users.ps1",
      "powershell C:\\Set-AuditRule\\Set-AuditRule.ps1",
      "powershell gpupdate /Force",
      "powershell Restart-Computer -Force",
    ]

  }

  root_block_device {
    delete_on_termination = true
  }
}
