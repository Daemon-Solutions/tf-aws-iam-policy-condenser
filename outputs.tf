locals {
  b64_output_policies = split(",", data.external.policy_condenser.result["b64_policies"])
}

data "null_data_source" "policies" {
  count = data.external.policy_condenser.result["policy_count"]

  inputs = {
    policies = base64decode(element(local.b64_output_policies, count.index))
  }
}

output "policies" {
  description = "A list of 1 or more IAM Policy documents in JSON format. These should be used with the aws_iam_policy resource to create the policies for the user, group or role."
  value       = data.null_data_source.policies.*.outputs
}

output "policy_count" {
  description = "The number of policies being returned. This is to help avoid the dreaded Terraform 'value cannot be computed'."
  value       = data.external.policy_condenser.result["policy_count"]
}
