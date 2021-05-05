# Written by: Jonathan Johnson

# Inital VPC
resource "aws_vpc" "default" {
  cidr_block = "172.18.0.0/16"
}

# Internet Gateway creation
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

# Route table to give VPC internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

# subnet creation
resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "172.18.39.0/24"
  map_public_ip_on_launch = true
}


resource "aws_vpc_dhcp_options" "default" {
  domain_name          = var.domain_name
  domain_name_servers  = concat([aws_instance.dc.private_ip], var.external_dns_servers)
  netbios_name_servers = [aws_instance.dc.private_ip]
 }

resource "aws_vpc_dhcp_options_association" "default" {
  vpc_id          = aws_vpc.default.id
  dhcp_options_id = aws_vpc_dhcp_options.default.id
}
