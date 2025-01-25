variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to be used as the origin for CloudFront."
}

variable "web_site_bucket_regional_domain_name" {
  type        = string
  description = "The regional domain name of the S3 bucket used as the origin for CloudFront."
}