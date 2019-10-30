output "policies" {
  description = "A list of 1 or more IAM Policy documents in JSON format. These should be used with the aws_iam_policy resource to create the policies for the user, group or role."
  value       = "${module.policy_condenser.policies}"
}
