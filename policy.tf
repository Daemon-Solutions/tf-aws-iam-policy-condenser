data "external" "policy_condenser" {
  program = ["/usr/bin/env", "python3", "${path.module}/policy_condenser.py", "--log"]

  query = {
    input_policies      = "${jsonencode(var.input_policies)}"
    policy_length_limit = "${lookup(var.policy_type_length_limit, var.policy_type)}"
    policy_version      = "${var.policy_version}"
  }
}
