# Creating RouteTable
resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
      Name = "my-rt"
    }
}

# Route Table Association with Subnet1
resource "aws_route_table_association" "rta1" {
    subnet_id = var.subnet1_id
    route_table_id = aws_route_table.rt.id  
}

# Route Table Association with Subnet2
resource "aws_route_table_association" "rta2" {
    subnet_id = var.subnet2_id
    route_table_id = aws_route_table.rt.id  
}