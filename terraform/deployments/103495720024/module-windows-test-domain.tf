module "windows_test_domain_module" {
  source = "../../modules/windows-test-domain"
  ip_allowlist = concat(
    module.common_vars.no_third_party_cidr_list,
    module.common_vars.concourse_public_cidr_list
  )
  environment           = var.environment
  public_key_name       = var.public_key_name
  public_key_path       = var.public_key_path
  private_key_path      = var.private_key_path
  domain_name           = var.domain_name
  splunk_config_bucket  = var.splunk_config_bucket
  splunk_forwarder_name = var.splunk_forwarder_name
}
