terraform {
  backend "s3" {
    bucket  = "gds-security-terraform"
    key     = "terraform/state/account/373632528784/service/windows-test-domain.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
