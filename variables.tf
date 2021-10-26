variable "input_policies" {
  description = "A list of IAM policy JSON strings to merge into as few policy documents as possible."
  type        = any
  default     = []
}

variable "policy_type" {
  type        = string
  description = "The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy."
}

variable "policy_type_length_limit" {
  description = "A map containing maximum length of the various types of IAM policy (user, group or role)."
  type        = map(string)

  default = {
    user  = 2048
    group = 5120
    role  = 10240
  }
}

variable "policy_version" {
  description = "The IAM policy version to use when generating the condensed policies."
  type        = string
  default     = "2012-10-17"
}
