resource "aws_s3_bucket" "frontend_content_bucket" {
  bucket           = "${lower(var.project)}-content-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-an"
  bucket_namespace = "account-regional"
  force_destroy    = true
  tags = merge({
    Name = "${var.project} Content Bucket"
  }, local.common_tags)
}