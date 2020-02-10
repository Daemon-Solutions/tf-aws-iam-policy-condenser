# tf-aws-iam-policy-condenser

Takes a list of IAM policies in JSON format and condenses the statements from them into as few as possible IAM policy documents based on the IAM policy length limits for the requested IAM policy type (user, group or role).

# Terraform Version Compatibility
| Module version | Terraform version |
|----------------|-------------------|
| \>= 20.0.0     | 0.12.x            |
| \<=1.x.x       | 0.11.x            |

## Tests

Tests against the Python part of the condenser module by running:

  make test

at the project root. *Note* These tests require Pytest.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| input\_policies | A list of IAM policy JSON strings to merge into as few policy documents as possible. | list | n/a | yes |
| policy\_type | The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy. | string | n/a | yes |
| policy\_type\_length\_limit | A map containing maximum length of the various types of IAM policy \(user, group or role\). | map | `<map>` | no |
| policy\_version | The IAM policy version to use when generating the condensed policies. | string | `"2012-10-17"` | no |

## Outputs

| Name | Description |
|------|-------------|
| policies | A list of 1 or more IAM Policy documents in JSON format. These should be used with the aws\_iam\_policy resource to create the policies for the user, group or role. |
| policy\_count | The number of policies being returned. This is to help avoid the dreaded Terraform 'value cannot be computed'. |
