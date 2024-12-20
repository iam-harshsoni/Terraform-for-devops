provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "harsh" {
  instance_type = "t2.micro"
  ami = "ami-0dee22c13ea7a9a67"
  tags = {
    Name = "ec2_instance_12"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket="harsh-s3-bucket-2024"
}

resource "aws_dynamodb_table" "terraform_lock" {

    name = "terraform-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}