output "dc_public_ip" {
  description = "The ID of the VPC"
  value       = module.windows_test_domain_module.dc_public_ip
}

output "wec_public_ip" {
  description = "The ID of the VPC"
  value       = module.windows_test_domain_module.wec_public_ip
}

output "private_key_file" {
  description = "The path to the generated private key file"
  value       = module.windows_test_domain_module.private_key_file
}

output "public_key_file" {
  description = "The path to the generated public key file"
  value       = module.windows_test_domain_module.public_key_file
}
