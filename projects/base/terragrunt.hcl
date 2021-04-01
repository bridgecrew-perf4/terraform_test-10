include {
  path = find_in_parent_folders()
}

remote_state {
  backend = "s3"
  config = {
    bucket  = local.config.bucket
    key     = "terraform/base/${path_relative_to_include()}.tfstate"
    region  = local.config.region
    encrypt = local.config.encrypt
  }
}