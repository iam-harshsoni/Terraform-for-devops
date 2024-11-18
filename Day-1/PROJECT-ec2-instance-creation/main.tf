provider "aws" {
  region = "ap-south-1"  # Set your desired AWS region 
}

resource "aws_instance" "demoTerra" {
    ami = "ami-0dee22c13ea7a9a67"
    instance_type = "t2.micro"
    subnet_id = "subnet-0d595fdf7d4273d6d"
    key_name = "mumbaiKeyPair"
}

output "example_output" {
  description = "output public ip of instance created"
  value       = resource.aws_instance.demoTerra.public_ip
}