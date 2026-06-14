data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "content_bucket_policy" {
  statement {
    sid    = "AllowCloudfrontToAccessBucket"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.infraprefix}-content-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-an/*"]
  }
}