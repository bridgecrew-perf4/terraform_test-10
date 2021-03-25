resource "aws_eip" "name" {
    vpc  = true
    tags = {
        Name = ""
    }
}

resource "aws_nat_gateway" "name" {
    subnet_id     = ""
    allocation_id = ""
    tags = {
        Name = ""
    }
}