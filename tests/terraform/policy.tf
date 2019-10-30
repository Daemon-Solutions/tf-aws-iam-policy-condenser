module "policy_condenser" {
  source = "../../"

  policy_type = "${var.policy_type}"

  policy_type_length_limit = "${var.policy_type_length_limit}"

  input_policies = []
}
