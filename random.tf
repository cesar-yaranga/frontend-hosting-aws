resource "random_string" "bucket_suffix" {
  length  = 6
  special = false
  upper   = false
}