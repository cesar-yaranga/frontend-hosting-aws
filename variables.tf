variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket used as the origin for CloudFront."
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the S3 bucket is located."
}