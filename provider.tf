provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = "~> 2.0"
  }
}