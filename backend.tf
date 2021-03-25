terraform {
  backend "s3" {
    bucket = "valis-develop"
    key    = "terraform/terraform.tfstate"
    region = "ap-northeast-1"
  }
}