module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.bucket_name}-${random_string.bucket_suffix.result}"
}

module "cloudfront" {
  source                               = "./modules/cloudfront"
  bucket_name                          = module.s3.bucket_name
  web_site_bucket_regional_domain_name = module.s3.regional_domain_name
}

module "s3_bucket_policy" {
  source                   = "./modules/s3_bucket_policy"
  bucket_web_site_id       = module.s3.bucket_web_site_id
  bucket_web_site_arn      = module.s3.bucket_web_site_arn
  website_distribution_arn = module.cloudfront.distribution_arn
}