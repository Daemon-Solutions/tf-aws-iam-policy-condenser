module "test_user_iam_policy" {
  source = "./test_policygen_module"

  policy_type              = "${var.policy_type}"
  policy_type_length_limit = "${var.policy_type_length_limit}"

  s3_readonly   = "1"
  s3_write      = "1"
  dynamodb_read = "1"

  s3_read_buckets = [
    "arn:aws:s3:::test-bucket1",
    "arn:aws:s3:::test-bucket2",
    "arn:aws:s3:::test-bucket3",
    "arn:aws:s3:::test-bucket4",
    "arn:aws:s3:::test-bucket5",
    "arn:aws:s3:::test-bucket6",
    "arn:aws:s3:::test-bucket7",
    "arn:aws:s3:::test-bucket8",
    "arn:aws:s3:::test-bucket9",
    "arn:aws:s3:::test-bucket10",
    "arn:aws:s3:::test-bucket11",
    "arn:aws:s3:::test-bucket12",
    "arn:aws:s3:::test-bucket13",
    "arn:aws:s3:::test-bucket14",
    "arn:aws:s3:::test-bucket15",
    "arn:aws:s3:::test-bucket16",
    "arn:aws:s3:::test-bucket17",
    "arn:aws:s3:::test-bucket18",
    "arn:aws:s3:::test-bucket19",
    "arn:aws:s3:::test-bucket20",
  ]

  s3_write_buckets = [
    "arn:aws:s3:::test-bucket1",
    "arn:aws:s3:::test-bucket2",
    "arn:aws:s3:::test-bucket3",
    "arn:aws:s3:::test-bucket4",
    "arn:aws:s3:::test-bucket5",
    "arn:aws:s3:::test-bucket6",
    "arn:aws:s3:::test-bucket7",
    "arn:aws:s3:::test-bucket8",
    "arn:aws:s3:::test-bucket9",
    "arn:aws:s3:::test-bucket10",
    "arn:aws:s3:::test-bucket11",
    "arn:aws:s3:::test-bucket12",
    "arn:aws:s3:::test-bucket13",
    "arn:aws:s3:::test-bucket14",
    "arn:aws:s3:::test-bucket15",
    "arn:aws:s3:::test-bucket16",
    "arn:aws:s3:::test-bucket17",
    "arn:aws:s3:::test-bucket18",
    "arn:aws:s3:::test-bucket19",
    "arn:aws:s3:::test-bucket20",
  ]

  dynamodb_read_tables = [
    "arn:aws:dynamodb:eu-west-1:${data.aws_caller_identity.current.account_id}:table/mytable",
  ]
}

resource "aws_iam_policy" "user_policies" {
  count  = "${length(module.test_user_iam_policy.policies)}"
  policy = "${lookup(module.test_user_iam_policy.policies[count.index], "policies")}"
}

output "policies" {
  value = "${module.test_user_iam_policy.policies}"
}