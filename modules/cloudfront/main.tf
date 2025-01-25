resource "aws_cloudfront_distribution" "distribution" {

  enabled             = true
  default_root_object = "/index.html"

  origin {
    domain_name              = var.web_site_bucket_regional_domain_name
    origin_id                = var.bucket_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

    custom_header {
      name  = "Access_Control_Allow_Methods"
      value = "GET, POST, PATCH, PUT, DELETE, OPTIONS"
    }

    custom_header {
      name  = "Access_Control_Allow_Headers"
      value = "Origin, Content-Type, X-Auth-Token"
    }

    custom_header {
      name  = "Access_Control_Allow_Origin"
      value = "*"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  custom_error_response {
    error_code            = 403
    response_page_path    = "/index.html"
    response_code         = 200
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code            = 404
    response_page_path    = "/index.html"
    response_code         = 200
    error_caching_min_ttl = 300
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.bucket_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "null_resource" "invalidate_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.distribution.id} --paths /*"
  }

  triggers = {
    frontend_hash = join("", [for f in fileset("${path.module}/../../frontend", "**/*") : filemd5("${path.module}/../../frontend/${f}")])
  }
}
