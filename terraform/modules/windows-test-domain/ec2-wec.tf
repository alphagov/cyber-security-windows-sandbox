/*
WECServer
This process is going to provision from a Pre-Built AMI.
This AMI already has the WEC subscriptions and WEC service deployed.
*/
resource "aws_instance" "wec" {
  depends_on = [null_resource.dc_setup_domain]
  instance_type = "t2.large"
  ami = data.aws_ami.windows_server_2016_base.image_id

  tags = {
    Name = "WECServer.${var.domain_name}"
  }

  subnet_id              = aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.windows.id]
  private_ip             = local.wec_private_ip

  iam_instance_profile   = aws_iam_instance_profile.wec_instance_profile.name

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
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC\\registry_system_enableula_sacl.ps1",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC\\registry_terminal_server_sacl.ps1",
      "powershell Restart-Computer -Force",
    ]

  }
  root_block_device {
    delete_on_termination = true
  }
}

resource "aws_iam_instance_profile" "wec_instance_profile" {
  name = "wec-developer_box_instance_profile"
  role = data.aws_iam_role.wec_exec_role.name
}

resource "null_resource" "wec_rename" {
    provisioner "remote-exec" {
    connection {
      host        = coalesce(aws_instance.wec.public_ip, aws_instance.wec.private_ip)
      type        = "winrm"
      user        = "Administrator"
      password    = rsadecrypt(aws_instance.wec.password_data,file(var.private_key_path))
      https       = true
      insecure    = true
      port        = 5986
    }
    inline = [
      "powershell Set-ExecutionPolicy Unrestricted -Force",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC\\rename_wec_computer.ps1",
      "powershell Restart-Computer -Force",
    ]

  }

}

resource "null_resource" "wec_configure" {
  depends_on = [null_resource.wec_rename]
  provisioner "remote-exec" {
    connection {
      host        = coalesce(aws_instance.wec.public_ip, aws_instance.wec.private_ip)
      type        = "winrm"
      user        = "Administrator"
      password    = rsadecrypt(aws_instance.wec.password_data,file(var.private_key_path))
      https       = true
      insecure    = true
      port        = 5986
    }
    inline = [
      "powershell Set-ExecutionPolicy Unrestricted -Force",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC\\configure_wec.ps1",
      "powershell Restart-Computer -Force",
    ]

  }

}

resource "null_resource" "wec_forward_to_splunk" {
  depends_on = [null_resource.wec_configure]
  provisioner "remote-exec" {
    connection {
      host        = coalesce(aws_instance.wec.public_ip, aws_instance.wec.private_ip)
      type        = "winrm"
      user        = "Administrator"
      password    = rsadecrypt(aws_instance.wec.password_data,file(var.private_key_path))
      https       = true
      insecure    = true
      port        = 5986
    }
    inline = [
      "powershell Set-ExecutionPolicy Unrestricted -Force",
      "powershell C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC\\install_packages.ps1",
      "powershell C:\\Set-AuditRule\\Set-AuditRule.ps1",
      "powershell Restart-Computer -Force",
    ]

  }

}