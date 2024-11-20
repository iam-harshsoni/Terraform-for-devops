provider "aws" {
  region = "ap-south-1"
}

variable "ami" {
    description = "value"
}

variable "key_name" {
  description = "value"
}

variable "instance_type" {
    description = "value"
    type = map(string)

    default = {
      "dev" = "t2.micro"
      "stage" = "t2.medium"
      "prod" = "t2.xlarge"
    }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami= var.ami
  key_name = var.key_name
  instance_type = lookup(var.instance_type,terraform.workspace,"t2.micro")
}

output "public_ip" {
  value = module.ec2_instance.pubic_id
}