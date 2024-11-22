variable "region" {
  default = "ap-south-1"
}

variable "vpc_name" {
  default = "my-vpc"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "sub1_name" {
  default = "subnet-1"
}

variable "sub2_name" {
  default = "subnet-2"
}

variable "sub1_cidr_block" {
  default = "10.0.0.0/24"
}

variable "sub2_cidr_block" {
  default = "10.0.1.0/24"
}

variable "sub1_availability_zone" {
  default = "ap-south-1a"
}

variable "sub2_availability_zone" {
  default = "ap-south-1b"
}

variable "igw_name" {
  default = "my-igw"
}

variable "rt-name" {
  default = "my-rt"
}

variable "security_group_name" {
  default = "web-sg"
}

variable "s3_bucket_name" {
  default = "harsh-demo-web-tera-24"
}


/*variable "ownership_controls" {
  
}

variable "public_aacess_block" {
  
}*/
 

variable "ami_id" {
  default = "ami-0dee22c13ea7a9a67"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_1_name" {
  default = "server-1"
}

variable "instance_2_name" {
   default = "server-2"
}

variable "lb_name" {
  default = "my-alb"
}

variable "lb_type" {
  default = "application"
}

variable "tg_name" {
  default = "my-tg"
}