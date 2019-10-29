locals {
  b64_output_policies = "${split(",", lookup(data.external.policy_condenser.result, "b64_policies"))}"
}

data "null_data_source" "policies" {
  count = "${length(local.b64_output_policies)}"

  inputs = {
    policies = "${base64decode(element(local.b64_output_policies, count.index))}"
  }
}

output "policies" {
  value = "${data.null_data_source.policies.*.outputs}"
}
