output "iam_role" {
value = aws_iam_role.s3_full_access_role.name
}

output "iam_policy" {
  value = aws_iam_policy.s3_full_access_policy.arn
}
