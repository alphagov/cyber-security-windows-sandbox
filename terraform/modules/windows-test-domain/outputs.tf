output "dc_public_ip" {
  value = aws_instance.dc.public_ip
}
output "wec_public_ip" {
  value = aws_instance.wec.public_ip
}
output "user_data" {
  value = local.user_data
}
output "private_key_file" {
  value = "${var.ssh_path}/${var.public_key_name}"
}
output "public_key_file" {
  value = "${var.ssh_path}/${var.public_key_name}.pub"
}

//output "RTO_public_ip" {
//  value = aws_instance.rto.public_ip
//}
//output "Apache_Guacamole_public_ip" {
//  value = "https://${aws_instance.guac.public_ip}:8443/guacamole"
//}
//output "Apache_Guacamole_Credentials" {
//  value = "guacadmin:guacadmin"
//}
//output "HELK_public_ip" {
//  value = aws_instance.helk.public_ip
//}
//
//output "ACCT001_public_ip" {
//  value = aws_instance.acct001.public_ip
//}
//
//output "IT001_public_ip" {
//  value = aws_instance.it001.public_ip
//}
//
//output "HR001_public_ip" {
//  value = aws_instance.hr001.public_ip
//}
//
//output "HELK_Kibana"{
// value = "https://${aws_instance.helk.public_ip}"
//}
//output "HELK_Kibana_Credentials"{
// value = "helk:hunting"
//}
