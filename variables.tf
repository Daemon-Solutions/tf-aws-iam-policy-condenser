variable "s3_readonly" {
  description = "Bit indicating whether to create a role policy to allow List/Get objects in a bucket"
  type        = "string"
  default     = "0"
}

variable "s3_read_buckets" {
  description = "A list of s3 buckets to create read role policies on"
  type        = "list"
  default     = []
}

variable "s3_write" {
  description = "Bit indicating whether to create a role policy to allow full access to a bucket"
  type        = "string"
  default     = "0"
}

variable "s3_write_buckets" {
  description = "A list of s3 buckets to create write role policies on"
  type        = "list"
  default     = []
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
