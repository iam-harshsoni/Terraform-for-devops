terraform {
  
  backend "s3" {
    bucket = "harsh-s3-bucket-2024"
    key    = "harsh/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
