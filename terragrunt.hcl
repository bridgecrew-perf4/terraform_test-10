locals {
    config = yamldecode(file(find_in_parent_folders("config.yml")))
}

inputs = {
  config = local.config
}

remote_state {
  backend = "s3"
  config = {
    bucket  = local.config.bucket
    key     = "${local.config.key_prefix}/${path_relative_to_include()}/terraform.tfstate"
    region  = local.config.region
    encrypt = local.config.encrypt
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
    required_version = "~> 0.14"
    backend "s3" {}
}
provider "aws" {
    region = "${local.config.region}"
}
EOF
}
