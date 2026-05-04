terraform {
  backend "s3" {
    bucket  = "safespot-terraform-state"
    key     = "dev/cicd/terraform.tfstate"
    region  = "ap-northeast-2"
    encrypt = true
  }
}