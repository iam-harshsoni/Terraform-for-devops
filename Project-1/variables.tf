variable "region" {
  default = "ap-south-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
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

variable "s3_bucket_name" {
  default = "harsh-demo-web-tera-24"
}

variable "ami_id" {
  default = "ami-0dee22c13ea7a9a67"
}

variable "instance_type" {
  default = "t2.micro"
}