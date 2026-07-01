terraform {
  backend "s3" {
    bucket       = "aws-three-tier-ha-tfstate"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
