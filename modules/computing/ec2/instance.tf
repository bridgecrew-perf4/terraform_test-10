resource "aws_instance" "name" {
  count           = 1
  ami             = "ami-09d28faae2e9e7138" # amazon linux
  instance_type   = ""
  subnet_id       = ""
  key_name        = ""
  security_groups = []
  tags = {
    Name = ""
  }
}