data "terraform_remote_state" "base" {
    backend = "s3"

    config = {
        bucket = "valis-develop"
        key = "terraform/base.tfstate"
        region = "ap-northeast-1"
    }
}