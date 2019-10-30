variable "cloudcraft_access" {
  description = "Whether to add a statement with the permissions required for Cloudcraft to access the account"
  default     = false
}

data "aws_iam_policy_document" "cloudcraft_access" {
  count = "${var.cloudcraft_access}"

  statement {
    actions = [
      "apigateway:Get",
      "autoscaling:Describe*",
      "cloudfront:List*",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "dynamodb:ListTagsOfResource",
      "ec2:Describe*",
      "elasticache:Describe*",
      "elasticache:List*",
      "elasticfilesystem:Describe*",
      "elasticloadbalancing:Describe*",
      "es:Describe*",
      "es:List*",
      "kinesis:Describe*",
      "kinesis:List*",
      "lambda:List*",
      "rds:Describe*",
      "rds:ListTagsForResource",
      "redshift:Describe*",
      "route53:List*",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketNotification",
      "s3:GetBucketTagging",
      "s3:GetEncryptionConfiguration",
      "s3:List*",
      "ses:Get*",
      "ses:List*",
      "sns:GetTopicAttributes",
      "sns:List*",
      "sqs:GetQueueAttributes",
      "sqs:ListQueues",
      "tag:Get*",
    ]

    resources = [
      "*",
    ]
  }
}
