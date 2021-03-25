terraform {
  backend "s3" {
    bucket = "valis-develop"
    key    = "terraform/cloudwatch/terraform.tfstate"
    region = "ap-northeast-1"
  }
}