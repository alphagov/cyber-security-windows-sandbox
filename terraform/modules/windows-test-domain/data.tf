data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_ami" "windows_server_2016_base" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Core-Base-2021.*"]
  }
}

data "aws_iam_role" "wec_exec_role" {
  name = "WECExecRole"
}

//data "aws_ami" "windows_10" {
//  owners = ["amazon"]
//  filter {
//    name = "name"
//    values = ["[find a suitable AMI"]
//  }
//}

#RTO AMI
//data "aws_ami" "rto_ami" {
//  owners = ["946612485350"]
//  filter {
//    name   = "name"
//    values = ["ubuntu18"]
//  }
//}

#Guacamole
//data "aws_ami" "guac_ami" {
//  owners = ["099720109477"]
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20190628"]
//  }
//}

#HELK Pre-built AMI
//data "aws_ami" "helk_ami" {
//  owners = ["946612485350"]
//  filter {
//    name   = "name"
//    values = ["ubuntu18"]
//  }
//}
#HFDC1 Pre-built AMI
//data "aws_ami" "dc_ami" {
//  owners = ["946612485350"]
//  filter {
//    name   = "name"
//    values = ["dcserver"]
//  }
//}

#WEC Pre-built AMI
//data "aws_ami" "wec_ami" {
//  owners = ["946612485350"]
//  filter {
//    name   = "name"
//    values = ["wecserver"]
//  }
//}

#ACCT001 Pre-built AMI
//data "aws_ami" "acct001_ami" {
//  owners = ["946612485350"]
//  filter {
//    name   = "name"
//    values = ["acct001"]
//  }
//}

#IT001 Pre-built AMI
//data "aws_ami" "it001_ami" {
//  owners = ["946612485350"]
//  filter {
//    name   = "name"
//    values = ["it001"]
//  }
//}

#HR001 Pre-built AMI
//data "aws_ami" "hr001_ami" {
//  owners = ["946612485350"]
//  filter {
//    name   = "name"
//    values = ["hr001"]
//  }
//}
