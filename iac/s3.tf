resource "aws_s3_bucket" "frontend_content_bucket" {
  bucket           = "${local.infraprefix}-content-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-an"
  bucket_namespace = "account-regional"
  force_destroy    = true
  tags = merge({
    Name = "${var.project} Content Bucket"
  }, local.common_tags)
}

resource "aws_s3_bucket_policy" "frontend_content_s3bucket_policy" {
  bucket = aws_s3_bucket.frontend_content_bucket.id
  policy = data.aws_iam_policy_document.content_bucket_policy.json
}

resource "aws_s3_object" "html_page" {
  key           = "${local.infraprefix}/index.html"
  bucket        = aws_s3_bucket.frontend_content_bucket.id
  source        = "../src/index.html"
  force_destroy = true
  etag          = filemd5("../src/index.html")
  content_type  = "text/html"
  tags = merge(local.common_tags, {
    Name = "${var.project} HTML File"
  })
}

resource "aws_s3_object" "javascript_file" {
  key           = "${local.infraprefix}/scripts.js"
  bucket        = aws_s3_bucket.frontend_content_bucket.id
  source        = "../src/scripts.js"
  force_destroy = true
  etag          = filemd5("../src/scripts.js")
  content_type  = "application/javascript"
  tags = merge(local.common_tags, {
    Name = "${var.project} Javascript File"
  })
}

resource "aws_s3_object" "css_stylesheet" {
  key           = "${local.infraprefix}/styles.css"
  bucket        = aws_s3_bucket.frontend_content_bucket.id
  source        = "../src/styles.css"
  force_destroy = true
  etag          = filemd5("../src/styles.css")
  content_type  = "text/css"
  tags = merge(local.common_tags, {
    Name = "${var.project} CSS Stylesheet"
  })
}