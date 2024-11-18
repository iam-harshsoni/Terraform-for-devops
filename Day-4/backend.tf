terraform {
  backend "s3" {
    bucket = "harsh-s3-demo-xy"
    key    = "harsh/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
