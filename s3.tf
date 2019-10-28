data "aws_iam_policy_document" "s3_readonly" {
  count = "${var.s3_readonly}"

  statement {
    effect = "Allow"

    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = "${concat(formatlist("arn:aws:s3:::%v", var.s3_read_buckets), formatlist("arn:aws:s3:::%v/*", var.s3_read_buckets))}"
  }
}

data "aws_iam_policy_document" "s3_write" {
  count = "${var.s3_write}"

  statement {
    actions = ["s3:*"]
    effect  = "Allow"

    resources = "${concat(formatlist("arn:aws:s3:::%v", var.s3_write_buckets), formatlist("arn:aws:s3:::%v/*", var.s3_write_buckets))}"
  }
}
