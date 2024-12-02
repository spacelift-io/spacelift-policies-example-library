package spacelift

# Test case for denying creation of resource type.
test_deny_creation_of_resource_type {
	deny["Static AWS credentials are evil (aws_iam_access_key.key_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_iam_access_key.key_1",
		"type": "aws_iam_access_key",
		"change": {"actions": ["create"]},
	}]}}
}
