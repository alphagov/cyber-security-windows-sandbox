terraform {
  backend "local" {
    ec2_endpoint           = "http://localhost:4597"
  }
}