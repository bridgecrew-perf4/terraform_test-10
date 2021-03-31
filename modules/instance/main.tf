resource "aws_instance" "instance" {
  count                  = 1
  ami                    = "ami-09d28faae2e9e7138"
  instance_type          = var.instance_type
  iam_instance_profile   = var.iam_role
  key_name               = "baba-test"
  subnet_id              = "subnet-0872ffa27ce8a2735"
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = var.name
  }
}
