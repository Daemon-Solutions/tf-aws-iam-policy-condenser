variable "policy_type" {
  type        = "string"
  description = "The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy."
}

variable "policy_type_length_limit" {
  description = "A map containing maximum length of the various types of IAM policy (user, group or role)."
  type        = "map"

  default = {
    group = 10240
    role  = 5120
    user  = 2048
  }
}

variable "policy_version" {
  description = "The IAM policy version to use when generating the condensed policies."
  type        = "string"
  default     = "2012-10-17"
}
