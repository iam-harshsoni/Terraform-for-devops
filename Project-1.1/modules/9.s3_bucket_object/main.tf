
# Uploading Object that will be used in website
resource "aws_s3_object" "object" {

  depends_on = [
    var.ownership_controls,
    var.public_aacess_block
  ]

  for_each = local.images

  bucket = var.s3_bucket_name
  key    = each.key
  source = "${path.module}/${each.value}"
  content_type = "image/png"
  acl = "public-read-write"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
   etag   = filemd5("${path.module}/${each.value}")
}