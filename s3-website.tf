#------------------------------------------------------------------------------
# Website S3 Bucket
#------------------------------------------------------------------------------
#tfsec:ignore:aws-s3-enable-versioning tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-logging

provider "aws" {
  region = "eu-west-2"
}

locals {

  tags = {
    application = var.name
    environment = var.environment
  }
  website_bucket_name = "${var.environment}-${var.s3_bucket_override_name}"
}

resource "aws_s3_bucket" "website" { # tfsec:ignore:AWS017
  
  bucket        = local.website_bucket_name
  force_destroy = true

   server_side_encryption_configuration {
     rule {
       apply_server_side_encryption_by_default {
         sse_algorithm = "AES256"
       }
     }
   }
}

resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status     = var.website_versioning_status
    mfa_delete = var.website_versioning_mfa_delete
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = var.website_index_document
  }

#  error_document {
#    key = var.website_error_document
#  }
}

#resource "aws_s3_bucket_policy" "website" {
#  bucket = aws_s3_bucket.website.id
#  policy = templatefile("${path.module}/templates/s3_website_bucket_policy.json", {
#    bucket_name = local.website_bucket_name
#  })
#}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = templatefile("${path.module}/templates/website_bucket_policy.json", {
  })
}

resource "aws_s3_bucket_public_access_block" "website_bucket_public_access_block" {

  bucket                  = aws_s3_bucket.website.id
  ignore_public_acls      = false
  block_public_acls       = false
  restrict_public_buckets = false
  block_public_policy     = false
}
