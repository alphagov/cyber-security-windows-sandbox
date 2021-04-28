module "windows_test_domain_module" {
  source                  = "../../modules/windows-test-domain"
  ip_whitelist            = module.common_vars.no_third_party_cidr_list
  environment             = var.environment
}
