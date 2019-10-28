locals {
  output_policies = "${split(",", lookup(data.external.policy_generator.result, "policies"))}"
}

data "null_data_source" "policies" {
  count = "${length(local.output_policies)}"

  inputs = {
    policies = "${base64decode(element(local.output_policies, count.index))}"
  }
}

output "policies" {
  value = "${data.null_data_source.policies.*.outputs}"
}
