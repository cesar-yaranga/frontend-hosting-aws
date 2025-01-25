output "distribution_arn" {
  value       = aws_cloudfront_distribution.distribution.arn
  description = "The ARN of the CloudFront Distribution."
}

output "url" {
  value       = "https://${aws_cloudfront_distribution.distribution.domain_name}"
  description = "The URL of the CloudFront Distribution."
}