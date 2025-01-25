output "bucket_name" {
  value       = aws_s3_bucket.web_site.bucket
  description = "The name of the S3 bucket."
}

output "bucket_web_site_id" {
  value       = aws_s3_bucket.web_site.id
  description = "The ID of the configured S3 bucket."
}

output "bucket_web_site_arn" {
  value       = aws_s3_bucket.web_site.arn
  description = "The ARN of the configured S3 bucket."
}

output "regional_domain_name" {
  value       = aws_s3_bucket.web_site.bucket_regional_domain_name
  description = "The regional domain name of the S3 bucket."
}