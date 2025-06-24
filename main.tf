module "this" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket                  = "adra-${var.service_name}-${var.environment}"
  acl                     = var.bucket_acl
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  tags = merge(
    var.additional_tags,
    var.tags
  )
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }


  lifecycle_rule = [
    {
      id      = "lifecycle_rule"
      enabled = var.lifecycle_rule_enabled

      transition = var.lifecycle_transition
    }
  ]


  versioning = {
    enabled = false
  }
}

