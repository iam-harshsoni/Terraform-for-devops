# Creating VPC
resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr

    tags = {
      Name = var.name
    }
}