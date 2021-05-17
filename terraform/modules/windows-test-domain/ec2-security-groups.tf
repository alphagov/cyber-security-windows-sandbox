# Security Group for Linux Machines
resource "aws_security_group" "linux" {
  name        = "linux_security_group"
  description = "Mordor: Security Group for the Linux Hosts"
  vpc_id	= aws_vpc.default.id

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = var.ip_whitelist
  }

  # Apache Guacamole Access
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "TCP"
    cidr_blocks = var.ip_whitelist
  }

  # Apache Spark Access
  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "TCP"
    cidr_blocks = var.ip_whitelist
  }

  # Kibana Access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = var.ip_whitelist
  }

  # Covenant
  ingress {
    from_port   = 7443
    to_port     = 7443
    protocol    = "TCP"
    cidr_blocks = var.ip_whitelist
  }
  # private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["172.18.39.0/24"]
  }

  # Connect to Internet Gateway - internet access
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "windows" {
  name        = "mordor_windows_workstations"
  description = "Security Group for Mordor Windows Machines"
  vpc_id      = aws_vpc.default.id

  # RDP
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.ip_whitelist
  }

  # WinRM
  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "TCP"
    cidr_blocks = var.ip_whitelist
  }

  # TLS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = var.ip_whitelist
  }


  # private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["172.18.39.0/24"]
  }

  # Connect to Internet Gateway - internet access
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["172.18.39.0/24"]
  }
}
