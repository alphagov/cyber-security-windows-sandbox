output "dc_public_ip" {
  description = "The ID of the VPC"
  value       = module.windows_test_domain_module.dc_public_ip
}

output "wec_public_ip" {
  description = "The ID of the VPC"
  value       = module.windows_test_domain_module.wec_public_ip
}