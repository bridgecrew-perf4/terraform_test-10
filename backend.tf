terraform {
  backend "s3" {
    bucket = "valis-develop"
    key    = "terraform/iam_user/terraform.tfstate"
    region = "ap-northeast-1"
  }
}