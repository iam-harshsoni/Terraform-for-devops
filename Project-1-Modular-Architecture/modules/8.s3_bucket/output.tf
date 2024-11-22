output "s3bucket_arn" {
  value = aws_s3_bucket.s3.arn
}

output "ownership_controls" {
  value = aws_s3_bucket_ownership_controls.example
}

output "public_aacess_block" {
  value = aws_s3_bucket_public_access_block.example
}