locals {
  policies = [
    "${data.aws_iam_policy_document.s3_readonly.*.json}",
    "${data.aws_iam_policy_document.s3_write.*.json}",
  ]
}

data "external" "policy_generator" {
  program = ["python3", "${path.module}/policy_generator.py"]

  query = {
    input_policies      = "${jsonencode(local.policies)}"
    policy_length_limit = "${lookup(var.policy_type_length_limit, var.policy_type)}"
    policy_version      = "${var.policy_version}"
  }
}
