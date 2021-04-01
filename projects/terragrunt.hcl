locals {
    config = yamldecode(file("${get_terragrunt_dir()}/../../config/config.yml"))
}

remote_state {
  backend = "s3"
  config = {
    bucket  = local.config.bucket
    key     = "terraform/${path_relative_to_include()}.tfstate"
    region  = local.config.region
    encrypt = local.config.encrypt
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
    region = "ap-northeast-1"
}
EOF
}