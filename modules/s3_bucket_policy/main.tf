resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_web_site_id

  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid    = "AllowCloudFrontServicePrincipal",
          Effect = "Allow",
          Action = ["s3:GetObject"],
          Resource = [
            "${var.bucket_web_site_arn}/*"
          ],
          Principal = {
            Service = "cloudfront.amazonaws.com"
          },
          Condition = {
            StringEquals = {
              "AWS:SourceArn" = var.website_distribution_arn
            }
          }
        },
        {
          Sid       = "DenyInsecureConnections",
          Effect    = "Deny",
          Principal = "*",
          Action    = ["s3:*"],
          Resource  = ["${var.bucket_web_site_arn}/*"]
          Condition = {
            Bool = {
              "aws:SecureTransport" : "false"
            }
          }
        }
      ]
  })
}
