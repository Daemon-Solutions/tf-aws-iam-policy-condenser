# tf-aws-iam-policy-condenser

Takes a list of IAM policies in JSON format and condenses the statements from them into as few as possible IAM policy documents based on the IAM policy length limits for the requested IAM policy type (user, group or role).