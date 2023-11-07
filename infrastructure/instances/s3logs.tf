# The Access log bucket with a special access policy to allow ELB to put logs
resource "aws_s3_bucket" "alb_logs" {
  bucket        = var.log_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.alb_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket_versionning" {
  bucket = aws_s3_bucket.alb_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = data.aws_iam_policy_document.elb_access.json
}
