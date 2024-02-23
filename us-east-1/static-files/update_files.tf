resource "aws_s3_bucket_object" "object" {
  depends_on = [aws_cloudfront_distribution.my_distribution]
  bucket     = local.s3_bucket_id
  key        = "index.html"
  source     = "./index.html"
  etag       = filemd5("./index.html")
}
