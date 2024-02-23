terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.0"
}

locals {
  cloudfront_distribution_id = "your-cloudfront-distribution-id"
  account_id                 = "523616670904" 
}


inputs = {
  bucket                       = "website-demo-albuquerque"
  force_destroy                = true
  acceleration_status          = "Suspended"
  request_payer                = "BucketOwner"
  restrict_public_buckets      = false
  control_object_ownership     = true
  block_public_acls            = false
  block_public_policy          = false
  attach_policy                = true
  tags                         = {
    Owner = "Anton"
  }
  website                      = {
    index_document = "index.html"
    error_document = "error.html"
  }
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontServicePrincipal",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::website-demo-albuquerque/*",
      "Condition": {
        "StringEquals": {
          "aws:SourceArn": "arn:aws:cloudfront::${local.account_id}:distribution/${local.cloudfront_distribution_id}"
        }
      }
    }
  ]
}
POLICY
}