terraform {
  backend "s3" {
    bucket = "truittjanney-terraform-state"
    key = "global/s3/terraform.tfstate"
    region = "us-east-2"
    use_lockfile = true
    encrypt = true
  }
}
