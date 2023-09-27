output "random_bucket_name_result" {
  value = random_string.bucket_name.result
}
output "bucket_name_result" {
  value = aws_s3_bucket.example.bucket_regional_domain_name
}