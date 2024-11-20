provider "aws" {
    region = "ap-south-1"
}

variable "ami" {
    description = "This is AMI for the instance"
}

variable "key_name" {
    description = "This is keyname for the instance"
}

variable "instance_type" {
    description = "This is the Instance Type, for example t2.micro"
  
}

resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
}

output "pubic_id" {
  value = aws_instance.example.public_ip
}