output "bucket_name_result" {
  value = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}