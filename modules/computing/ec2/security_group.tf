resource "aws_security_group" "name" {
    name            = ""
    description     = ""
    vpc_id          = ""

    ingress {
        from_port   =
        to_port     =
        protocol    = ""
        cidr_blocks = []
    }
    egress {
        from_port   =
        to_port     =
        protocol    =
        cidr_blocks = []
    }
}