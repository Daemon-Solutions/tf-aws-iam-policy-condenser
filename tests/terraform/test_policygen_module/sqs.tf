variable "sqs_list" {
  description = "Bit indicating whether to create a policy to allow listing SQS queues (this is automatically added if any other access to SQS queues is granted)"
  default     = false
}

variable "sqs_readonly" {
  description = "Bit indicating whether to create a policy to allow list and read queue messages."
  default     = false
}

variable "sqs_read_queues" {
  description = "A list of SQS queues to allow read access to via the generated policies"
  type        = "list"
  default     = []
}

variable "sqs_write" {
  description = "Bit indicating whether to create a policy to allow write access to a SQS queues and their messages."
  default     = false
}

variable "sqs_write_queues" {
  description = "A list of SQS queues to allow writing to"
  type        = "list"
  default     = []
}

variable "sqs_full_access" {
  description = "Bit indicating whether to create a policy to allow full access to a SQS queue (including modifying and deleting the queue)"
  default     = false
}

variable "sqs_full_access_queues" {
  description = "A list of SQS queues to allow full access to"
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "sqs_list_queues" {
  count = "${var.sqs_list || var.sqs_readonly || var.sqs_write || var.sqs_full_access ? "1" : "0"}"

  statement {
    sid = "SQSListQueues"

    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListQueueTags",
      "sqs:ListQueues",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "sqs_readonly" {
  count = "${var.sqs_readonly}"

  statement {
    sid = "SQSReadAccessQueues"

    actions = [
      "sqs:ReceiveMessage",
    ]

    resources = "${var.sqs_read_queues}"
  }
}

data "aws_iam_policy_document" "sqs_write" {
  count = "${var.sqs_write}"

  statement {
    sid = "SQSWriteAccessQueues"

    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
    ]

    resources = "${var.sqs_write_queues}"
  }
}

data "aws_iam_policy_document" "sqs_full_access" {
  count = "${var.sqs_full_access}"

  statement {
    sid       = "SQSFullAccessQueues"
    actions   = ["sqs:*"]
    resources = "${var.sqs_full_access_queues}"
  }
}