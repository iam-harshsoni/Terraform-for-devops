 //creating a vpc
 resource "aws_vpc" "myvpc" {
   cidr_block = var.cidr
 }

//creating subnet1
 resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
 }

 //creating subnet2
 resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "ap-south-1b"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
 }

//Creating Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id  
}

//Creating Route-Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id
  route  {
    cidr_block="0.0.0.0/0"    
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.rt.id  
}

resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.sub2.id
    route_table_id = aws_route_table.rt.id  
}

resource "aws_security_group" "webSg" {

    name = "web"
    vpc_id = aws_vpc.myvpc.id

    //inbound rule for HTTP
    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] //its a list of ips so we are keeping it inside []
    }

    //inbound rule for SSH
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] //its a list of ips so we are keeping it inside []
    }

    //outbound rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] //its a list of ips so we are keeping it inside []
    }

    tags = {
        Name = "Web-sg"
    }  
}

resource "aws_s3_bucket" "s3" {
  bucket = "my-s3-bucket-demo-terraform-2024"
}

/*resource "aws_instance" "server1" {

    ami = "ami-0dee22c13ea7a9a67"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webSg.id]
    subnet_id = aws_subnet.sub1.id
    user_data = base64decode(file(userdata.sh))

    tags = {
      Name = "instance-1"
    }  
}

resource "aws_instance" "server2" {

    ami = "ami-0dee22c13ea7a9a67"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webSg.id]
    subnet_id = aws_subnet.sub2.id
    user_data = base64decode(file(userdata.sh))

    tags = {
      Name = "instance-2"
    }  
}*/