# tf-aws-iam-policy-generator

A module similar to tf-aws-iam-instance-profile for generating IAM policies for various different uses. e.g. policies for attaching to user, groups or roles. The purpose of this is to allow us to have well tested IAM policies that can be easily used.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apigateway\_full\_access | Bit indicating whether to create a policy to allow full access to APIGateway APIs | string | `"false"` | no |
| apigateway\_full\_access\_apis | A list of APIGateway APIs to allow full access to | list | `<list>` | no |
| apigateway\_read | Bit indicating whether to create a policy to allow read only access to APIGateway APIs | string | `"false"` | no |
| apigateway\_read\_apis | A list of APIGateway APIs to allow reading from | list | `<list>` | no |
| apigateway\_write | Bit indicating whether to create a policy to allow write access to APIGateway APIs | string | `"false"` | no |
| apigateway\_write\_apis | A list of APIGateway APIs to allow writing to | list | `<list>` | no |
| cloudcraft\_access | Whether to add a statement with the permissions required for Cloudcraft to access the account | string | `"false"` | no |
| dynamodb\_full\_access | Bit indicating whether to create a policy to allow full access to dynamodb tables | string | `"false"` | no |
| dynamodb\_full\_access\_tables | A list of dynamodb tables to allow full access to | list | `<list>` | no |
| dynamodb\_list | Bit indicating whether to create a policy to allow listing dynamodb tables \(this is automatically added if any other access to dynamodb is granted\) | string | `"false"` | no |
| dynamodb\_read | Bit indicating whether to create a policy to allow read only access to dynamodb tables | string | `"false"` | no |
| dynamodb\_read\_tables | A list of dynamodb tables to allow reading from | list | `<list>` | no |
| dynamodb\_write | Bit indicating whether to create a policy to allow write access to dynamodb tables | string | `"false"` | no |
| dynamodb\_write\_tables | A list of dynamodb tables to allow writing to | list | `<list>` | no |
| policy\_type | The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy. | string | n/a | yes |
| policy\_type\_length\_limit | A map containing maximum length of the various types of IAM policy \(user, group or role\). | map | `<map>` | no |
| policy\_version | The IAM policy version to use when generating the condensed policies. | string | `"2012-10-17"` | no |
| s3\_full\_access | Bit indicating whether to create a policy to allow full access to a bucket \(including modifying and deleting the bucket\) | string | `"false"` | no |
| s3\_full\_access\_buckets | A list of S3 buckets to create policies to allow full access to | list | `<list>` | no |
| s3\_list | Bit indicating whether to create a policy to allow listing buckets \(this is automatically added if any other access to buckets is granted\) | string | `"false"` | no |
| s3\_read\_buckets | A list of S3 buckets to create allow access to via the generated policies | list | `<list>` | no |
| s3\_readonly | Bit indicating whether to create a policy to allow List/Get objects in a bucket | string | `"false"` | no |
| s3\_write | Bit indicating whether to create a policy to allow write access to a buckets objects and their ACLs. | string | `"false"` | no |
| s3\_write\_buckets | A list of S3 buckets to create policies to allow writing to | list | `<list>` | no |
| sqs\_full\_access | Bit indicating whether to create a policy to allow full access to a SQS queue \(including modifying and deleting the queue\) | string | `"false"` | no |
| sqs\_full\_access\_queues | A list of SQS queues to allow full access to | list | `<list>` | no |
| sqs\_list | Bit indicating whether to create a policy to allow listing SQS queues \(this is automatically added if any other access to SQS queues is granted\) | string | `"false"` | no |
| sqs\_read\_queues | A list of SQS queues to allow read access to via the generated policies | list | `<list>` | no |
| sqs\_readonly | Bit indicating whether to create a policy to allow list and read queue messages. | string | `"false"` | no |
| sqs\_write | Bit indicating whether to create a policy to allow write access to a SQS queues and their messages. | string | `"false"` | no |
| sqs\_write\_queues | A list of SQS queues to allow writing to | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| policies | A list of 1 or more IAM Policy documents in JSON format. These should be used with the aws\_iam\_policy resource to create the policies for the user, group or role. |