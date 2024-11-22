# Creating Subnet1
resource "aws_subnet" "sub1" {
    vpc_id = var.vpc_id
    cidr_block = var.sub1_cidr_block
    availability_zone = var.sub1_availability_zone
    map_public_ip_on_launch = true

    tags = {
      Name = var.sub1_name
    }
}

# Creating Subnet2
resource "aws_subnet" "sub2" {
    vpc_id = var.vpc_id
    cidr_block = var.sub2_cidr_block
    availability_zone = var.sub2_availability_zone
    map_public_ip_on_launch = true

    tags = {
      Name = var.sub2_name
    }
}