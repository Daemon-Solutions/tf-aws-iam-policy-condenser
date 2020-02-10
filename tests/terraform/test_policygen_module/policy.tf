module "policy_condenser" {
  source = "../../../"

  policy_type = var.policy_type

  input_policies = [
    data.aws_iam_policy_document.apigateway_full_access.*.json,
    data.aws_iam_policy_document.apigateway_read.*.json,
    data.aws_iam_policy_document.apigateway_write.*.json,
    data.aws_iam_policy_document.cloudcraft_access.*.json,
    data.aws_iam_policy_document.dynamodb_full_access.*.json,
    data.aws_iam_policy_document.dynamodb_list.*.json,
    data.aws_iam_policy_document.dynamodb_read.*.json,
    data.aws_iam_policy_document.dynamodb_write.*.json,
    data.aws_iam_policy_document.s3_full_access.*.json,
    data.aws_iam_policy_document.s3_list.*.json,
    data.aws_iam_policy_document.s3_readonly.*.json,
    data.aws_iam_policy_document.s3_write.*.json,
  ]
}
