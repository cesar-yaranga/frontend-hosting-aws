resource "aws_s3_bucket" "web_site" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "pab" {
  bucket = aws_s3_bucket.web_site.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.web_site.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_object" "frontend" {
  for_each = fileset("${path.module}/../../frontend", "**/*")
  bucket   = aws_s3_bucket.web_site.bucket
  key      = each.value
  source   = "${path.module}/../../frontend/${each.value}"
  content_type = lookup(
    {
      "html" = "text/html",
      "css"  = "text/css",
      "js"   = "application/javascript",
      "png"  = "image/png",
      "jpg"  = "image/jpeg",
      "jpeg" = "image/jpeg"
    },
    regex("[^.]+$", each.value),
    "application/octet-stream"
  )
  etag = filemd5("${path.module}/../../frontend/${each.value}") # Detecta cambios en los archivos
}
