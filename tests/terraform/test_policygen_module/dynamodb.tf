variable "dynamodb_list" {
  description = "Bit indicating whether to create a policy to allow listing dynamodb tables (this is automatically added if any other access to dynamodb is granted)"
  default     = false
}

variable "dynamodb_read" {
  description = "Bit indicating whether to create a policy to allow read only access to dynamodb tables"
  default     = false
}

variable "dynamodb_read_tables" {
  description = "A list of dynamodb tables to allow reading from"
  type        = "list"
  default     = []
}

variable "dynamodb_write" {
  description = "Bit indicating whether to create a policy to allow write access to dynamodb tables"
  default     = false
}

variable "dynamodb_write_tables" {
  description = "A list of dynamodb tables to allow writing to"
  type        = "list"
  default     = []
}

variable "dynamodb_full_access" {
  description = "Bit indicating whether to create a policy to allow full access to dynamodb tables"
  default     = false
}

variable "dynamodb_full_access_tables" {
  description = "A list of dynamodb tables to allow full access to"
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "dynamodb_list" {
  count = "${var.dynamodb_list || var.dynamodb_read || var.dynamodb_write || var.dynamodb_full_access ? "1" : "0"}"

  statement {
    sid    = "DynamoDBListAndDescribeTables"
    effect = "Allow"

    actions = [
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "dynamodb_read" {
  count = "${var.dynamodb_read}"

  statement {
    sid = "DynamoDBReadOnlyTableAccess"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeStream",
      "dynamodb:DescribeTable",
      "dynamodb:Get*",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = ["${var.dynamodb_read_tables}"]
  }
}

data "aws_iam_policy_document" "dynamodb_write" {
  count = "${var.dynamodb_write}"

  statement {
    sid = "DynamoDBWriteTableAccess"

    actions = [
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:UpdateItem",
      "dynamodb:PutItem",
    ]

    effect = "Allow"

    resources = [
      "${var.dynamodb_write_tables}",
    ]
  }
}

data "aws_iam_policy_document" "dynamodb_full_access" {
  count = "${var.dynamodb_full_access}"

  statement {
    sid = "DynamoDBFullAccessTables"

    actions = [
      "dynamodb:*",
    ]

    effect = "Allow"

    resources = [
      "${var.dynamodb_full_access_tables}",
    ]
  }
}
