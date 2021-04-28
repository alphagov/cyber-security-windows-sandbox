/*
Windows Workstations:
This process is going to provision from a Pre-Built AMI.
These AMI's already has been domain joined prior to this process

*/
 # ACCT001 Build
//resource "aws_instance" "acct001" {
//  instance_type = "t2.medium"
//  ami = coalesce(data.aws_ami.windows_10.image_id)
//
//  tags = {
//    Name = "ACCT001.shire.com"
//  }
//
//  subnet_id              = aws_subnet.default.id
//  vpc_security_group_ids = [aws_security_group.windows.id]
//  private_ip             = "172.18.39.100"
//
//
//   provisioner "remote-exec" {
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "winrm"
//      user        = "User"
//      password    = "S@lv@m3!M0d3"
//      insecure    = "true"
//      port        = 5985
//      timeout     = "10m"
//
//    }
//    inline = [
//      "powershell Set-ExecutionPolicy Unrestricted -Force",
//      "powershell git clone https://github.com/Cyb3rWard0g/mordor.git C:\\mordor",
//      "powershell C:\\mordor\\environment\\shire\\aws\\scripts\\Workstations\\registry_system_enableula_sacl.ps1",
//      "powershell C:\\mordor\\environment\\shire\\aws\\scripts\\Workstations\\registry_terminal_server_sacl.ps1",
//      "powershell git clone https://github.com/hunters-forge/Set-AuditRule.git C:\\Set-AuditRule",
//      "powershell C:\\Set-AuditRule\\Set-AuditRule.ps1",
//      "powershell git clone https://github.com/jsecurity101/VulnerableService.git C:\\vulnerableservice",
//      "powershell C:\\vulnerableservice\\vulnservice.ps1",
//      "powershell Restart-Computer -Force",
//    ]
//
//  }
//
//  root_block_device {
//    delete_on_termination = true
//  }
//}


 # HR001 Build
//resource "aws_instance" "hr001" {
//  instance_type = "t2.medium"
//  ami = coalesce(data.aws_ami.windows_10.image_id)
//
//  tags = {
//    Name = "HR001.shire.com"
//  }
//
//  subnet_id              = aws_subnet.default.id
//  vpc_security_group_ids = [aws_security_group.windows.id]
//  private_ip             = "172.18.39.106"
//
//  provisioner "remote-exec" {
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "winrm"
//      user        = "User"
//      password    = "S@lv@m3!M0d3"
//      insecure    = "true"
//       port        = 5985
//      timeout     = "10m"
//    }
//    inline = [
//      "powershell Set-ExecutionPolicy Unrestricted -Force",
//      "powershell git clone https://github.com/Cyb3rWard0g/mordor.git C:\\mordor",
//      "powershell C:\\mordor\\environment\\shire\\aws\\scripts\\Workstations\\registry_system_enableula_sacl.ps1",
//      "powershell C:\\mordor\\environment\\shire\\aws\\scripts\\Workstations\\registry_terminal_server_sacl.ps1",
//      "powershell git clone https://github.com/hunters-forge/Set-AuditRule.git C:\\Set-AuditRule",
//      "powershell C:\\Set-AuditRule\\Set-AuditRule.ps1",
//      "powershell git clone https://github.com/jsecurity101/VulnerableService.git C:\\vulnerableservice",
//      "powershell C:\\vulnerableservice\\vulnservice.ps1",
//      "powershell Restart-Computer -Force",
//    ]
//
//  }
//
//  root_block_device {
//    delete_on_termination = true
//  }
//}


 # IT001 Build
//resource "aws_instance" "it001" {
//  instance_type = "t2.medium"
//  ami = coalesce(data.aws_ami.windows_10.image_id)
//
//  tags = {
//    Name = "IT001.shire.com"
//  }
//
//  subnet_id              = aws_subnet.default.id
//  vpc_security_group_ids = [aws_security_group.windows.id]
//  private_ip             = "172.18.39.105"
//
//  provisioner "remote-exec" {
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "winrm"
//      user        = "User"
//      password    = "S@lv@m3!M0d3"
//      insecure    = "true"
//      port        = 5985
//      timeout     = "10m"
//    }
//    inline = [
//      "powershell Set-ExecutionPolicy Unrestricted -Force",
//      "powershell git clone https://github.com/Cyb3rWard0g/mordor.git C:\\mordor",
//      "powershell C:\\mordor\\environment\\shire\\aws\\scripts\\Workstations\\registry_system_enableula_sacl.ps1",
//      "powershell C:\\mordor\\environment\\shire\\aws\\scripts\\Workstations\\registry_terminal_server_sacl.ps1",
//      "powershell git clone https://github.com/hunters-forge/Set-AuditRule.git C:\\Set-AuditRule",
//      "powershell C:\\Set-AuditRule\\Set-AuditRule.ps1",
//      "powershell git clone https://github.com/jsecurity101/VulnerableService.git C:\\vulnerableservice",
//      "powershell C:\\vulnerableservice\\vulnservice.ps1",
//      "powershell Restart-Computer -Force",
//    ]
//
//  }
//  root_block_device {
//    delete_on_termination = true
//  }
//}
