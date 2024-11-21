resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.sub1_cidr_block
    availability_zone = var.sub1_availability_zone
    map_public_ip_on_launch = true
}

resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.sub2_cidr_block
    availability_zone = var.sub2_availability_zone
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id  
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
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
    name="web"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]        
    }
    
    tags = {
        Name = "Web-sg"
    }  
}


# Creating S3 Bucket
resource "aws_s3_bucket" "s3" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.s3.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
 
# Enable pulbic Access
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.s3.id
  acl    = "public-read-write"
}

/*
# Enable public access
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "*"
        Resource = "${aws_s3_bucket.s3.arn}/*"
      }
    ]
  })
}*/

# Terraform Block that defines local variable
locals {
  images = {
    "terraform-1.png" = "${path.module}/images/terraform-1.png",
    "terraform-2.png" = "${path.module}/images/terraform-2.png" 
  }
}

# Uploading Object that will be used in website
resource "aws_s3_object" "object" {

  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example
  ]

  for_each = local.images

  bucket = var.s3_bucket_name
  key    = each.key
  source = each.value
  content_type = "image/png"
  acl = "public-read-write"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(each.value) 
}

# Create IAM Role
resource "aws_iam_role" "s3_full_access_role" {
  name        = "s3_full_access_role"
  description = "Grants full access to S3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com" # or other services that need access
        }
      },
    ]
  })
}

# Create IAM Policy for S3 Full Access
resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "s3_full_access_policy"
  description = "Grants full access to S3"

  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
          "s3-object-lambda:*"
        ]
        Resource = "*"
      },
    ]
  })
}

# Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  role       = aws_iam_role.s3_full_access_role.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}

# Create an Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.s3_full_access_role.name
}

resource "aws_instance" "server1" {

    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.sub1.id
    security_groups = [aws_security_group.webSg.id]

    # Attached IAM Role
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

    user_data = base64encode(file("userdata.sh"))
    tags = {
      Name = "server-1"
    }  
}

resource "aws_instance" "server2" {

    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.sub2.id
    security_groups = [aws_security_group.webSg.id]

    # Attached IAM Role
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

    user_data = base64encode(file("userdata2.sh"))
    tags = {
      Name = "server-2"
    }  
}

// Create Load Balancer
resource "aws_lb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"

  security_groups    = [aws_security_group.webSg.id]
  subnets            = [aws_subnet.sub1.id,aws_subnet.sub2.id,]

  tags = {
    Name = "test"
  }
}

# Creating Target Group
resource "aws_lb_target_group" "tg" {
  name     = "myTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# Attaching Target Group to Load Balancer
resource "aws_lb_target_group_attachment" "attach_all_instance" {
   for_each       = {
    server1 = aws_instance.server1.id,
    server2 = aws_instance.server2.id
  }
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = each.value
  port             = 80
}

# Created Load Balancer Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# Output Variables for public IP 
output "public_ip_instance_1" {
  value = aws_instance.server1.public_ip
}
output "public_ip_instance_2" {
  value = aws_instance.server2.public_ip
}
output "loadbalancerdns" {
  value = aws_lb.myalb.dns_name
}