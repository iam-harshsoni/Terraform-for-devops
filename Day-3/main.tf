provider "aws" {
    region = "ap-south-1"
}

module "ec2_instance" {
  source = "./module/ec2_instance"
  ami_value = "ami-0dee22c13ea7a9a67"
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-0d595fdf7d4273d6d" 
}

output "ec2_public_ip" {
  value = module.ec2_instance.public-ip-address
}