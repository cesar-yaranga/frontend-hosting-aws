variable "bucket_web_site_id" {
  type        = string
  description = "The S3 bucket name used as the origin for CloudFront."
}

variable "bucket_web_site_arn" {
  type        = string
  description = "The ARN of the S3 bucket used as the origin for CloudFront."
}

variable "website_distribution_arn" {
  type        = string
  description = "The ARN of the CloudFront distribution for the website."
}