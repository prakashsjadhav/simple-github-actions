variable "name" {
  description = "The name of the site"
  default = "Ops-Portal_UI"
}
  
variable "environment" {
  description = "The environment name"
  default = "feature"
}

variable "s3_region" {
  type = "string"
  default = "eu-west-2"
}

variable "s3_bucket_override_name" {
  description = "Override name for S3 Bucket"
  type = "string"
  default = "ops-portal-UI"
}

variable "website_versioning_status" {
  description = "(Optional) The versioning state of the bucket. Valid values: Enabled or Suspended. Defaults to Enabled"
  type        = string
  default     = "Enabled"
}

variable "website_versioning_mfa_delete" {
  description = "(Optional) Specifies whether MFA delete is enabled in the bucket versioning configuration. Valid values: Enabled or Disabled. Defaults to Disabled"
  type        = string
  default     = "Disabled"
}

variable "website_index_document" {
  description = "Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders.  Defaults to index.html"
  type        = string
  default     = "index.html"
}



