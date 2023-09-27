resource "random_string" "bucket_name" {
  length           = 8
  special          = false
  upper            = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
  
  tags = {
    UserUUID        = var.user_uuid
  }
}
