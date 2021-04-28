/*
Apache Guacamole
This process will call a community ami and build out the Apache Gaucamole Service through a scipt provided: https://github.com/jsecurity101/ApacheGuacamole.
Changes were made to fit the lab's requirements.

The Provisioning process will update the system, add github, add a user with a password, add that user to sudoers file, then
update the sshd_config file to allow Password Authentication. User has option to login with ssh keys or user's password
*/
//resource "aws_instance" "guac" {
//  instance_type = "t2.medium"
//  ami           = coalesce(data.aws_ami.guac_ami.image_id, var.guac_ami)
//
//  tags = {
//    Name = "Apache-Guacamole"
//  }
//
//  subnet_id              = aws_subnet.default.id
//  vpc_security_group_ids = [aws_security_group.linux.id]
//  key_name               = aws_key_pair.auth.key_name
//  private_ip             = "172.18.39.9"
//
//  provisioner "file" {
//    source          = "../scripts/ApacheGuacamole/user-mapping.xml"
//    destination     = "user-mapping.xml"
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//  provisioner "file" {
//    source          = "../scripts/ApacheGuacamole/sshd_config"
//    destination     = "sshd_config"
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "sudo apt-get update",
//      "sudo apt-get intall git -y",
//      "sudo adduser --disabled-password --gecos \"\" guac && echo 'guac:guac' | sudo chpasswd",
//      "sudo mkdir /home/guac/.ssh && sudo cp /home/ubuntu/.ssh/authorized_keys /home/guac/.ssh/authorized_keys && sudo chown -R guac:guac /home/guac/.ssh",
//      "echo 'guac   ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers",
//      "sudo mv ~/sshd_config /etc/ssh/sshd_config",
//      "sudo service sshd restart",
//    ]
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "sudo git clone https://github.com/jsecurity101/ApacheGuacamole.git",
//      "sudo apt-get install libcairo2-dev libjpeg62-dev libpng12-dev libossp-uuid-dev libfreerdp-dev libpango1.0-dev libssh2-1-dev libssh-dev tomcat7 tomcat7-admin tomcat7-user -y",
//      "cd ApacheGuacamole",
//      "sudo bash ApacheGuacamole.sh",
//      "cd ~/",
//      "sudo mv /home/ubuntu/user-mapping.xml /etc/guacamole/user-mapping.xml",
//      "sudo service tomcat7 restart",
//    ]
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "guac"
//      private_key = file(var.private_key_path)
//    }
//  }
//  root_block_device {
//    delete_on_termination = true
//    volume_size           = 100
//  }
//}
/*
HELK
This process will call a community ami and build out HELK : https://github.com/Cyb3rWard0g/HELK.
HELK is installed with option 3: Kafka, KSQL, ELK, NGNIX, Spark, Jupyter.
HELK can be found in the /opt/ folder.

The Provisioning process will update the system, add github, add a user with a password, add that user to sudoers file, then
update the sshd_config file to allow Password Authentication. User has option to login with ssh keys or user's password
*/
//resource "aws_instance" "helk" {
//  instance_type = "t2.xlarge"
//  ami           = coalesce(data.aws_ami.helk_ami.image_id, var.helk_ami)
//
//  tags = {
//    Name = "HELK"
//  }
//
//  subnet_id              = aws_subnet.default.id
//  vpc_security_group_ids = [aws_security_group.linux.id]
//  key_name               = aws_key_pair.auth.key_name
//  private_ip             = "172.18.39.6"
//
//
//  provisioner "file" {
//    source          = "../scripts/HELK/sshd_config"
//    destination     = "sshd_config"
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//
//  provisioner "file" {
//    source          = "../scripts/HELK/install_helk.sh"
//    destination     = "install_helk.sh"
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "sudo adduser --disabled-password --gecos \"\" aragorn && echo 'aragorn:aragorn' | sudo chpasswd",
//      "sudo mkdir /home/aragorn/.ssh && sudo cp /home/ubuntu/.ssh/authorized_keys /home/aragorn/.ssh/authorized_keys && sudo chown -R aragorn:aragorn /home/aragorn/.ssh",
//      "echo 'aragorn   ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers",
//      "sudo mv ~/sshd_config /etc/ssh/sshd_config",
//      "sudo service sshd restart",
//    ]
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "sudo git clone https://github.com/Cyb3rWard0g/mordor.git /opt/mordor",
//      "sudo rm /var/lib/apt/lists/lock",
//      "sudo rm /var/cache/apt/archives/lock",
//      "sudo rm /var/lib/dpkg/lock",
//      "sudo dpkg --configure -a",
//      "sudo rm /var/lib/dpkg/lock-frontend",
//      "sudo dpkg --configure -a",
//      "sudo bash /opt/mordor/environment/shire/aws/scripts/HELK/requirements.sh",
//      "sudo apt-get install apache2-utils -y",
//      "sudo apt-get install htpasswd -y",
//      "sudo apt-get install kafkacat -y",
//      "sudo rm -r /snap/bin/docker-compose",
//      "sudo rm -r /usr/local/bin/docker-compose",
//      "sudo apt-get install docker -y",
//      "sudo apt-get install docker-compose -y",
//      "sudo git clone https://github.com/Cyb3rWard0g/HELK.git /opt/HELK",
//      "cd /home/ubuntu",
//      "sudo bash install_helk.sh",
//    ]
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "aragorn"
//      private_key = file(var.private_key_path)
//    }
//  }
//
//  root_block_device {
//    delete_on_termination = true
//    volume_size           = 100
//  }
//}
/*
RTO
This process will call a community ami and build out the Empire C2 Framework: https://github.com/EmpireProject/Empire.
Empire can be found in the /opt/ folder.

The Provisioning process will update the system, add github, add a user with a password, add that user to sudoers file, then
update the sshd_config file to allow Password Authentication. User has option to login with ssh keys or user's password
*/
//resource "aws_instance" "rto" {
//  instance_type = "t2.medium"
//  ami           = coalesce(data.aws_ami.rto_ami.image_id, var.rto_ami)
//
//  tags = {
//   Name = "RTO"
//  }
//
//  subnet_id              = aws_subnet.default.id
//  vpc_security_group_ids = [aws_security_group.linux.id]
//  key_name               = aws_key_pair.auth.key_name
//  private_ip             = "172.18.39.8"
//
//  provisioner "file" {
//    source          = "../scripts/RTO/sshd_config"
//    destination     = "sshd_config"
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//  provisioner "file" {
//    source          = "../scripts/RTO/install_empire.sh"
//    destination     = "install_empire.sh"
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//  # Created User 'wardog'. Copying ssh keys.
//  provisioner "remote-exec" {
//    inline = [
//      "sudo apt-get update",
//      "sudo adduser --disabled-password --gecos \"\" wardog && echo 'wardog:wardog' | sudo chpasswd",
//      "sudo mkdir /home/wardog/.ssh && sudo cp /home/ubuntu/.ssh/authorized_keys /home/wardog/.ssh/authorized_keys && sudo chown -R wardog:wardog /home/wardog/.ssh",
//      "echo 'wardog   ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers",
//      "sudo rm /var/lib/apt/lists/lock",
//      "sudo rm /var/cache/apt/archives/lock",
//      "sudo rm /var/lib/dpkg/lock",
//      "sudo dpkg --configure -a",
//      "sudo rm /var/lib/dpkg/lock-frontend",
//      "sudo dpkg --configure -a",
//      "sudo apt-get install docker -y",
//      "sudo apt-get install docker-compose -y",
//      "sudo apt-get install git -y",
//      "sudo mv ~/sshd_config /etc/ssh/sshd_config",
//      "sudo service sshd restart",
//      "sudo git clone https://github.com/Cyb3rWard0g/mordor.git",
//      "cd ~/mordor/environment/shire/empire",
//      "sudo docker-compose -f docker-compose-empire.yml up --build -d",
//      "sudo docker stop mordor-empire",
//      "sudo rm -r ~/mordor",
//      "cd ~/",
//      "sudo git clone --recurse-submodules https://github.com/cobbr/Covenant /opt/Covenant",
//      "cd /opt/Covenant/Covenant/",
//      "sudo docker build -t covenant .",
//    ]
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file(var.private_key_path)
//    }
//  }
//  root_block_device {
//   delete_on_termination = true
//    volume_size           = 100
//  }
//}
