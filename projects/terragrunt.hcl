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

dependency "base" {
  config_path = "./base"
}