variable "apigateway_read" {
  description = "Bit indicating whether to create a policy to allow read only access to APIGateway APIs"
  default     = false
}

variable "apigateway_read_apis" {
  description = "A list of APIGateway APIs to allow reading from"
  type        = "list"
  default     = []
}

variable "apigateway_write" {
  description = "Bit indicating whether to create a policy to allow write access to APIGateway APIs"
  type        = "string"
  default     = false
}

variable "apigateway_write_apis" {
  description = "A list of APIGateway APIs to allow writing to"
  type        = "list"
  default     = []
}

variable "apigateway_full_access" {
  description = "Bit indicating whether to create a policy to allow full access to APIGateway APIs"
  type        = "string"
  default     = false
}

variable "apigateway_full_access_apis" {
  description = "A list of APIGateway APIs to allow full access to"
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "apigateway_read" {
  count = "${var.apigateway_read}"

  statement {
    sid = "APIGatewayReadOnlyAccessAPIs"

    actions = [
      "apigateway:GET",
    ]

    resources = ["${var.apigateway_read_apis}"]
  }
}

data "aws_iam_policy_document" "apigateway_write" {
  count = "${var.apigateway_write}"

  statement {
    sid = "APIGatewayWriteAccessAPIs"

    actions = [
      "apigateway:DELETE",
      "apigateway:PATCH",
      "apigateway:POST",
      "apigateway:PUT",
      "apigateway:SetWebACL",
      "apigateway:UpdateRestApiPolicy",
    ]

    resources = [
      "${var.apigateway_write_apis}",
    ]
  }
}

data "aws_iam_policy_document" "apigateway_full_access" {
  count = "${var.apigateway_full_access}"

  statement {
    sid = "APIGatewayFullAccessAPIs"

    actions = [
      "apigateway:*",
    ]

    resources = [
      "${var.apigateway_full_access_apis}",
    ]
  }
}