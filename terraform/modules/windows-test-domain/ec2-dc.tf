/*
HFDC1
This process is going to provision from a Pre-Built AMI.
This AMI already has the forest, GPOs, and Users deployed.
*/
resource "aws_instance" "dc" {
  instance_type = "t2.medium"
  ami = data.aws_ami.windows_server_2016_base.image_id

  tags = {
    Name = "HFDC1.shire.com"
  }

  subnet_id              = aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.windows.id]
  private_ip             = "172.18.39.5"


   provisioner "remote-exec" {
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "winrm"
      user        = "Administrator"
      password    = aws_ssm_parameter.windows_admin_password.value
      insecure    = "true"
      port        = 5985

    }
    inline = [
      "powershell Set-ExecutionPolicy Unrestricted -Force",
      "powershell Remove-Item -Force C:\\alphagov-windows-sandbox -Recurse",
      "powershell git clone https://github.com/alphagov/cyber-security-windows-sandbox.git C:\\alphagov-windows-sandbox",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC\\registry_system_enableula_sacl.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC\\registry_terminal_server_sacl.ps1",
      "powershell git clone https://github.com/OTRF/Set-AuditRule.git C:\\Set-AuditRule",
      "powershell C:\\Set-AuditRule\\Set-AuditRule.ps1",
      "powershell gpupdate /Force",
      "powershell Restart-Computer -Force",
    ]

  }

  root_block_device {
    delete_on_termination = true
  }
}
