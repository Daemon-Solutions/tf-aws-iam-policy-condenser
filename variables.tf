variable "input_policies" {
  description = "A list of IAM policy JSON strings to merge into as few policy documents as possible."
  type        = "list"
}

variable "policy_type" {
  type        = "string"
  description = "The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy."
}

variable "policy_type_length_limit" {
  type = "map"

  default = {
    group = 10240
    role  = 5120
    user  = 2048
  }
}

variable "policy_version" {
  type    = "string"
  default = "2012-10-17"
}
