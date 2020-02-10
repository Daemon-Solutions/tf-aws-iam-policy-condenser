locals {
  b64_output_policies = split(",", lookup(data.external.policy_condenser.result, "b64_policies"))
}

output "policies" {
  description = "A list of 1 or more IAM Policy documents in JSON format. These should be used with the aws_iam_policy resource to create the policies for the user, group or role."
  value       = [for output_policy in local.b64_output_policies: base64decode(output_policy)]
}

output "policy_count" {
  description = "The number of policies being returned. This is to help avoid the dreaded Terraform 'value cannot be computed'."
  value       = lookup(data.external.policy_condenser.result, "policy_count")
}
