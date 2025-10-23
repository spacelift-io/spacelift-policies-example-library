package spacelift_test

import data.spacelift
import rego.v1

# Test case for denying creation of aws resources.
test_deny_creation_of_aws_resource if {
	spacelift.deny["We have moved to GCP, find an equivalent there (aws_iam_access_key.key_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_iam_access_key.key_1",
		"type": "aws_iam_access_key",
		"change": {"actions": ["create"]},
		"provider_name": "aws",
	}]}}
}

# Test case for allowing deletion of aws resources.
test_allow_deletion_of_aws_resource if {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_iam_access_key.key_1",
		"type": "aws_iam_access_key",
		"change": {"actions": ["update"]},
	}]}}
	count(spacelift.deny) == 0 with input as inp
}
