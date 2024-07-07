resource "aws_s3_bucket" "website_resiliency" {
  bucket = "81da30af-3fd5-44e4-b5b6-60110b443ba5-website-resiliency" // 81da30af-3fd5-44e4-b5b6-60110b443ba5 my Udacity userId
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "website_resiliency" {
  bucket = aws_s3_bucket.website_resiliency.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "website_resiliency" {
  bucket = aws_s3_bucket.website_resiliency.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website_resiliency" {
  bucket = aws_s3_bucket.website_resiliency.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "website_resiliency"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.website_resiliency.arn,
          "${aws_s3_bucket.website_resiliency.arn}/*",
        ]
      }
    ]
  })
}

resource "aws_s3_object" "upload_website" {
  for_each      = fileset("../../s3/", "*")
  bucket        = aws_s3_bucket.website_resiliency.id
  key           = each.value
  source        = "../../s3/${each.value}"
  content_type  = "text/html"
  etag   = filemd5("../../s3/${each.value}") // prevent re-upload when re-apply without file changes
}

resource "aws_s3_bucket_website_configuration" "website_resiliency" {
  bucket = aws_s3_bucket.website_resiliency.id

  index_document {
    suffix = "index.html"
  }
}