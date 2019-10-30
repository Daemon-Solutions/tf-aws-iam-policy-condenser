variable "s3_list" {
  description = "Bit indicating whether to create a policy to allow listing buckets (this is automatically added if any other access to buckets is granted)"
  default     = false
}

variable "s3_readonly" {
  description = "Bit indicating whether to create a policy to allow List/Get objects in a bucket"
  default     = false
}

variable "s3_read_buckets" {
  description = "A list of S3 buckets to create allow access to via the generated policies"
  type        = "list"
  default     = []
}

variable "s3_write" {
  description = "Bit indicating whether to create a policy to allow write access to a buckets objects and their ACLs."
  default     = false
}

variable "s3_write_buckets" {
  description = "A list of S3 buckets to create policies to allow writing to"
  type        = "list"
  default     = []
}

variable "s3_full_access" {
  description = "Bit indicating whether to create a policy to allow full access to a bucket (including modifying and deleting the bucket)"
  default     = false
}

variable "s3_full_access_buckets" {
  description = "A list of S3 buckets to create policies to allow full access to"
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "s3_list" {
  count = "${var.s3_list || var.s3_readonly || var.s3_write || var.s3_full_access ? "1" : "0"}"

  statement {
    sid = "S3ListBuckets"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "s3_readonly" {
  count = "${var.s3_readonly}"

  statement {
    sid = "S3ReadAccessBuckets"

    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = "${concat(formatlist("%v", var.s3_read_buckets), formatlist("%v/*", var.s3_read_buckets))}"
  }
}

data "aws_iam_policy_document" "s3_write" {
  count = "${var.s3_write}"

  statement {
    sid = "S3WriteAccessBuckets"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
    ]

    resources = "${concat(formatlist("%v", var.s3_write_buckets), formatlist("%v/*", var.s3_write_buckets))}"
  }
}

data "aws_iam_policy_document" "s3_full_access" {
  count = "${var.s3_full_access}"

  statement {
    sid       = "S3FullAccessBuckets"
    actions   = ["s3:*"]
    resources = "${concat(formatlist("%v", var.s3_full_access_buckets), formatlist("%v/*", var.s3_full_access_buckets))}"
  }
}
