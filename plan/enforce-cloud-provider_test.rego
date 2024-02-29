package spacelift

# Test case for denying creation of aws resources.
test_deny_creation_of_aws_resource {
	deny["We have moved to GCP, find an equivalent there (aws_iam_access_key.key_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_iam_access_key.key_1",
		"type": "aws_iam_access_key",
		"change": {"actions": ["create"]},
		"provider_name": "aws",
	}]}}
}

# Test case for allowing deletion of aws resources.
test_allow_deletion_of_aws_resource {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_iam_access_key.key_1",
		"type": "aws_iam_access_key",
		"change": {"actions": ["update"]},
	}]}}
	count(deny) == 0 with input as inp
}
